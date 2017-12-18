Return-Path: <khazhy@google.com>
MIME-Version: 1.0
In-Reply-To: <20171218210138.GB10493@redhat.com>
References: <20171114231022.42961-1-khazhy@google.com> <20171116165033.4noofd6gkaj6x3yl@kernel.org>
 <CACGdZY+OdN-yfTGFgd1qmXBn+z3OkKMX3FeCnwSdYVHj7HdQyw@mail.gmail.com>
 <20171117192614.4knf72v26iir6tpi@kernel.org> <CACGdZYLo+EBC-1Q03YVJjwd=TVEMH9zErKJE2ebtEtLpqLyqjQ@mail.gmail.com>
 <CACGdZYL3rXUyEEbxJMcYp+q86fD=D0N06MQfmXQCfF3CGBqLiw@mail.gmail.com>
 <20171218182934.GB7474@redhat.com> <CACGdZY+fyB6O8VH2SeRVeo3HJRu-oOVkdEUScfKrXqqYCZpE5Q@mail.gmail.com>
 <20171218210138.GB10493@redhat.com>
From: Khazhismel Kumykov <khazhy@google.com>
Date: Mon, 18 Dec 2017 14:22:53 -0800
Message-ID: <CACGdZY+Qn7BjjDrYtgMG7UU03Rvd9ZYDa-7SHRf+mTcjw4Y=Ag@mail.gmail.com>
Subject: Re: [RFC PATCH] blk-throttle: add burst allowance.
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Shaohua Li <shli@kernel.org>, shli@fb.com, tj@kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="001a1134e9a0b431130560a4cab6"
List-ID: <linux-block@vger.kernel.org>

--001a1134e9a0b431130560a4cab6
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 18, 2017 at 1:01 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Mon, Dec 18, 2017 at 12:39:50PM -0800, Khazhismel Kumykov wrote:
>> On Mon, Dec 18, 2017 at 10:29 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
>> > On Mon, Dec 18, 2017 at 10:16:02AM -0800, Khazhismel Kumykov wrote:
>> >> On Mon, Nov 20, 2017 at 8:36 PM, Khazhismel Kumykov <khazhy@google.com> wrote:
>> >> > On Fri, Nov 17, 2017 at 11:26 AM, Shaohua Li <shli@kernel.org> wrote:
>> >> >> On Thu, Nov 16, 2017 at 08:25:58PM -0800, Khazhismel Kumykov wrote:
>> >> >>> On Thu, Nov 16, 2017 at 8:50 AM, Shaohua Li <shli@kernel.org> wrote:
>> >> >>> > On Tue, Nov 14, 2017 at 03:10:22PM -0800, Khazhismel Kumykov wrote:
>> >> >>> >> Allows configuration additional bytes or ios before a throttle is
>> >> >>> >> triggered.
>> >> >>> >>
>> >> >>> >> This allows implementation of a bucket style rate-limit/throttle on a
>> >> >>> >> block device. Previously, bursting to a device was limited to allowance
>> >> >>> >> granted in a single throtl_slice (similar to a bucket with limit N and
>> >> >>> >> refill rate N/slice).
>> >> >>> >>
>> >> >>> >> Additional parameters bytes/io_burst_conf defined for tg, which define a
>> >> >>> >> number of bytes/ios that must be depleted before throttling happens. A
>> >> >>> >> tg that does not deplete this allowance functions as though it has no
>> >> >>> >> configured limits. tgs earn additional allowance at rate defined by
>> >> >>> >> bps/iops for the tg. Once a tg has *_disp > *_burst_conf, throttling
>> >> >>> >> kicks in. If a tg is idle for a while, it will again have some burst
>> >> >>> >> allowance before it gets throttled again.
>> >> >>> >>
>> >> >>> >> slice_end for a tg is extended until io_disp/byte_disp would fall to 0,
>> >> >>> >> when all "used" burst allowance would be earned back. trim_slice still
>> >> >>> >> does progress slice_start as before and decrements *_disp as before, and
>> >> >>> >> tgs continue to get bytes/ios in throtl_slice intervals.
>> >> >>> >
>> >> >>> > Can you describe why we need this? It would be great if you can describe the
>> >> >>> > usage model and an example. Does this work for io.low/io.max or both?
>> >> >>> >
>> >> >>> > Thanks,
>> >> >>> > Shaohua
>> >> >>> >
>> >> >>>
>> >> >>> Use case that brought this up was configuring limits for a remote
>> >> >>> shared device. Bursting beyond io.max is desired but only for so much
>> >> >>> before the limit kicks in, afterwards with sustained usage throughput
>> >> >>> is capped. (This proactively avoids remote-side limits). In that case
>> >> >>> one would configure in a root container io.max + io.burst, and
>> >> >>> configure low/other limits on descendants sharing the resource on the
>> >> >>> same node.
>> >> >>>
>> >> >>> With this patch, so long as tg has not dispatched more than the burst,
>> >> >>> no limit is applied at all by that tg, including limit imposed by
>> >> >>> io.low in tg_iops_limit, etc.
>> >> >>
>> >> >> I'd appreciate if you can give more details about the 'why'. 'configuring
>> >> >> limits for a remote shared device' doesn't justify the change.
>> >> >
>> >> > This is to configure a bursty workload (and associated device) with
>> >> > known/allowed expected burst size, but to not allow full utilization
>> >> > of the device for extended periods of time for QoS. During idle or low
>> >> > use periods the burst allowance accrues, and then tasks can burst well
>> >> > beyond the configured throttle up to the limit, afterwards is
>> >> > throttled. A constant throttle speed isn't sufficient for this as you
>> >> > can only burst 1 slice worth, but a limit of sorts is desirable for
>> >> > preventing over utilization of the shared device. This type of limit
>> >> > is also slightly different than what i understand io.low does in local
>> >> > cases in that tg is only high priority/unthrottled if it is bursty,
>> >> > and is limited with constant usage
>> >> >
>> >> > Khazhy
>> >>
>> >> Hi Shaohua,
>> >>
>> >> Does this clarify the reason for this patch? Is this (or something
>> >> similar) a good fit for inclusion in blk-throttle?
>> >>
>> >
>> > So does this brust have to be per cgroup. I mean if thortl_slice was
>> > configurable, that will allow to control the size of burst. (Just that
>> > it will be for all cgroups). If that works, that might be a simpler
>> > solution.
>> >
>> > Vivek
>>
>> The purpose for this configuration vs. increasing throtl_slice is the
>> behavior when the burst runs out. io/bytes allowance is given in
>> intervals of throtl_slice, so for long throtl_slice for those devices
>> that exceed the limit will see extended periods with no IO, rather
>> than at throttled speed. With this once burst is run out, since the
>> burst allowance is on top of the throttle, the device can continue to
>> be used more smoothly at the configured throttled speed.
>
> I thought that whole idea of burst is that there is some bursty IO which
> will quickly finish. If workload expects a stedy state IO rate, then
> why to allow a large burst to begin with.
>
> So yes, increasing throtl slice will should allow you to dispatch a slice
> worth of IO and then throttle the process. If burst has finished, and
> process does another burst of IO, it will may be dispatch it immediately
> too (Depending on where are we in slice at the time).
>
>> For this we
>> do want a throttle group with both the "steady state" rate + the burst
>> amount, and we get cgroup support with that.
>
> So if burst IO is on top of steady configured rate, how frequently you
> allow burst IO?
>

This is mostly for the unexpected behavior: workload is expected to
have large burst(s) not exceeding the burst limit, and idle most of
the time, but isn't directly controlled by us, and in the case that it
does exceed limit/ is sustained we want to allow at throttled speed
rather than it cut off. e.g. device which allows for large burst that
refills over 60s, it is preferable to have a user workload which is
non-conformant/broken/whatnot to have consistent slower IOs rather
than being blocked on IO for potentially 60s at a time. The steady
state io rate is so we don't have a situation where the IO rate is 0
for a long time

>>
>> I notice with cgroupv2 io, it seems no longer to configure a
>> device-wide throttle group e.g. on the root cgroup. (and putting
>> restrictions on root cgroup isn't an option) For something like this,
>> it does make sense to want to configure just for the device, vs. per
>> cgroup, perhaps there is somewhere better it would fit than as cgroup
>> option? perhaps have configuration on device node for a throttle group
>> for the device?
>
> Default throtle slice value per device might be reasonable. Though not
> perfect for the cases where people want same throtl slice value for
> whole of the system.
>
throtl_slice is already per device as I see, with non/rotational
having different values, just isn't configurable.

> Vivek

--001a1134e9a0b431130560a4cab6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS5wYJKoZIhvcNAQcCoIIS2DCCEtQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBNMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWltZWNhMS5j
cnQwHQYDVR0OBBYEFMnO7tLwRUm/Kh/G63DTEdz9N5wmMB8GA1UdIwQYMBaAFMs4ErDHmcB4koyz
IZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8v
d3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQA5gzhiP9g5DzgYyM4K
/OtFFFKyrluiKx9OmOb1Mx9UCxEi9vzRrG5j1rFMAwNAx+xEESoq1JVNe8fJKBimOsKpWstAhYlO
Cg6Qm43dzb+5CcPWDC3j6XxfsUIKvektE79/IeVhdRVj+Op1gSEGaBJQP2c0/MeXPPhQKPjAPVQW
bEOJaemCXr1UIoEHMoisd0Smdm1NjxLYLk3bK1RDgO0RTu2hNmVAT9WypS9uiquOQWeK3u9QBuUK
BhOZjgo70YosoRVRBIKNqStZ++IpaDEWfDme3EH4H8tlOzwCvAiO8c1uF7ZX68wXWJPjq6uxu1cZ
5lT83BZ34AElNAzFvsLhMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIMPycjokgk
Gdp8HTY2MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAsJ3aeSTS56CfeUI6u+q14
ZHsevmMXfaMt6kv/UMV7hjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xNzEyMTgyMjIyNTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglg
hkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAZQYNCdRJDXQcmrh8Cj+/hujaIWj8f2dtDnjhASrp
izBZuiaK1VIw38p2Rfl4R9MxgwX7rLsnIYBRIvIrr7WMkrjlD3BLNL7/xGtVm/NumCD2Fsx44WaU
5NAi/PSFACpZD7SCa/X8/HmcTfE2BJ9eXPrgbnm4vqbhiwZ1WmffMO8qbyw89DXFHFyjtf3SsnJB
wD0sBA1F9yqmvh+cFKDJfNpCU/E+OsAOOgVetYqwWJhkhHntL43xdZz4bxLzJjrzoF+p+YMvxS54
ToGez08E8kLk/LxibFnZHLY4nb+l765SeEggvMGth0LP9rVevGIxSQuw2qeHmFjRlf11R9t4FA==
--001a1134e9a0b431130560a4cab6--
