Return-Path: <khazhy@google.com>
MIME-Version: 1.0
In-Reply-To: <CACGdZYLo+EBC-1Q03YVJjwd=TVEMH9zErKJE2ebtEtLpqLyqjQ@mail.gmail.com>
References: <20171114231022.42961-1-khazhy@google.com> <20171116165033.4noofd6gkaj6x3yl@kernel.org>
 <CACGdZY+OdN-yfTGFgd1qmXBn+z3OkKMX3FeCnwSdYVHj7HdQyw@mail.gmail.com>
 <20171117192614.4knf72v26iir6tpi@kernel.org> <CACGdZYLo+EBC-1Q03YVJjwd=TVEMH9zErKJE2ebtEtLpqLyqjQ@mail.gmail.com>
From: Khazhismel Kumykov <khazhy@google.com>
Date: Wed, 6 Dec 2017 16:29:59 -0800
Message-ID: <CACGdZYLeFNmUJWVP8B0wMo1mktG3xgW0fJSnchzp1P4+R0XsFg@mail.gmail.com>
Subject: Re: [RFC PATCH] blk-throttle: add burst allowance.
To: Shaohua Li <shli@kernel.org>
Cc: shli@fb.com, vgoyal@redhat.com, tj@kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="001a11397b841596ea055fb52b81"
List-ID: <linux-block@vger.kernel.org>

--001a11397b841596ea055fb52b81
Content-Type: multipart/alternative; boundary="001a11397b840eea24055fb52b9b"

--001a11397b840eea24055fb52b9b
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 20, 2017 at 8:36 PM, Khazhismel Kumykov <khazhy@google.com>
wrote:

> On Fri, Nov 17, 2017 at 11:26 AM, Shaohua Li <shli@kernel.org> wrote:
> > On Thu, Nov 16, 2017 at 08:25:58PM -0800, Khazhismel Kumykov wrote:
> >> On Thu, Nov 16, 2017 at 8:50 AM, Shaohua Li <shli@kernel.org> wrote:
> >> > On Tue, Nov 14, 2017 at 03:10:22PM -0800, Khazhismel Kumykov wrote:
> >> >> Allows configuration additional bytes or ios before a throttle is
> >> >> triggered.
> >> >>
> >> >> This allows implementation of a bucket style rate-limit/throttle on a
> >> >> block device. Previously, bursting to a device was limited to
> allowance
> >> >> granted in a single throtl_slice (similar to a bucket with limit N
> and
> >> >> refill rate N/slice).
> >> >>
> >> >> Additional parameters bytes/io_burst_conf defined for tg, which
> define a
> >> >> number of bytes/ios that must be depleted before throttling happens.
> A
> >> >> tg that does not deplete this allowance functions as though it has no
> >> >> configured limits. tgs earn additional allowance at rate defined by
> >> >> bps/iops for the tg. Once a tg has *_disp > *_burst_conf, throttling
> >> >> kicks in. If a tg is idle for a while, it will again have some burst
> >> >> allowance before it gets throttled again.
> >> >>
> >> >> slice_end for a tg is extended until io_disp/byte_disp would fall to
> 0,
> >> >> when all "used" burst allowance would be earned back. trim_slice
> still
> >> >> does progress slice_start as before and decrements *_disp as before,
> and
> >> >> tgs continue to get bytes/ios in throtl_slice intervals.
> >> >
> >> > Can you describe why we need this? It would be great if you can
> describe the
> >> > usage model and an example. Does this work for io.low/io.max or both?
> >> >
> >> > Thanks,
> >> > Shaohua
> >> >
> >>
> >> Use case that brought this up was configuring limits for a remote
> >> shared device. Bursting beyond io.max is desired but only for so much
> >> before the limit kicks in, afterwards with sustained usage throughput
> >> is capped. (This proactively avoids remote-side limits). In that case
> >> one would configure in a root container io.max + io.burst, and
> >> configure low/other limits on descendants sharing the resource on the
> >> same node.
> >>
> >> With this patch, so long as tg has not dispatched more than the burst,
> >> no limit is applied at all by that tg, including limit imposed by
> >> io.low in tg_iops_limit, etc.
> >
> > I'd appreciate if you can give more details about the 'why'. 'configuring
> > limits for a remote shared device' doesn't justify the change.
>
> This is to configure a bursty workload (and associated device) with
> known/allowed expected burst size, but to not allow full utilization
> of the device for extended periods of time for QoS. During idle or low
> use periods the burst allowance accrues, and then tasks can burst well
> beyond the configured throttle up to the limit, afterwards is
> throttled. A constant throttle speed isn't sufficient for this as you
> can only burst 1 slice worth, but a limit of sorts is desirable for
> preventing over utilization of the shared device. This type of limit
> is also slightly different than what i understand io.low does in local
> cases in that tg is only high priority/unthrottled if it is bursty,
> and is limited with constant usage
>
> Khazhy
>
Ping? Not sure if this was lost

--001a11397b840eea24055fb52b9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Nov 20, 2017 at 8:36 PM, Khazhismel Kumykov <span dir=3D"ltr">&=
lt;<a href=3D"mailto:khazhy@google.com" target=3D"_blank">khazhy@google.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On Fri, Nov 17, 2017 a=
t 11:26 AM, Shaohua Li &lt;<a href=3D"mailto:shli@kernel.org">shli@kernel.o=
rg</a>&gt; wrote:<br>
&gt; On Thu, Nov 16, 2017 at 08:25:58PM -0800, Khazhismel Kumykov wrote:<br=
>
&gt;&gt; On Thu, Nov 16, 2017 at 8:50 AM, Shaohua Li &lt;<a href=3D"mailto:=
shli@kernel.org">shli@kernel.org</a>&gt; wrote:<br>
&gt;&gt; &gt; On Tue, Nov 14, 2017 at 03:10:22PM -0800, Khazhismel Kumykov =
wrote:<br>
&gt;&gt; &gt;&gt; Allows configuration additional bytes or ios before a thr=
ottle is<br>
&gt;&gt; &gt;&gt; triggered.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; This allows implementation of a bucket style rate-limit/t=
hrottle on a<br>
&gt;&gt; &gt;&gt; block device. Previously, bursting to a device was limite=
d to allowance<br>
&gt;&gt; &gt;&gt; granted in a single throtl_slice (similar to a bucket wit=
h limit N and<br>
&gt;&gt; &gt;&gt; refill rate N/slice).<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Additional parameters bytes/io_burst_conf defined for tg,=
 which define a<br>
&gt;&gt; &gt;&gt; number of bytes/ios that must be depleted before throttli=
ng happens. A<br>
&gt;&gt; &gt;&gt; tg that does not deplete this allowance functions as thou=
gh it has no<br>
&gt;&gt; &gt;&gt; configured limits. tgs earn additional allowance at rate =
defined by<br>
&gt;&gt; &gt;&gt; bps/iops for the tg. Once a tg has *_disp &gt; *_burst_co=
nf, throttling<br>
&gt;&gt; &gt;&gt; kicks in. If a tg is idle for a while, it will again have=
 some burst<br>
&gt;&gt; &gt;&gt; allowance before it gets throttled again.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; slice_end for a tg is extended until io_disp/byte_disp wo=
uld fall to 0,<br>
&gt;&gt; &gt;&gt; when all &quot;used&quot; burst allowance would be earned=
 back. trim_slice still<br>
&gt;&gt; &gt;&gt; does progress slice_start as before and decrements *_disp=
 as before, and<br>
&gt;&gt; &gt;&gt; tgs continue to get bytes/ios in throtl_slice intervals.<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Can you describe why we need this? It would be great if you c=
an describe the<br>
&gt;&gt; &gt; usage model and an example. Does this work for io.low/io.max =
or both?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks,<br>
&gt;&gt; &gt; Shaohua<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt; Use case that brought this up was configuring limits for a remote<=
br>
&gt;&gt; shared device. Bursting beyond io.max is desired but only for so m=
uch<br>
&gt;&gt; before the limit kicks in, afterwards with sustained usage through=
put<br>
&gt;&gt; is capped. (This proactively avoids remote-side limits). In that c=
ase<br>
&gt;&gt; one would configure in a root container io.max + io.burst, and<br>
&gt;&gt; configure low/other limits on descendants sharing the resource on =
the<br>
&gt;&gt; same node.<br>
&gt;&gt;<br>
&gt;&gt; With this patch, so long as tg has not dispatched more than the bu=
rst,<br>
&gt;&gt; no limit is applied at all by that tg, including limit imposed by<=
br>
&gt;&gt; io.low in tg_iops_limit, etc.<br>
&gt;<br>
&gt; I&#39;d appreciate if you can give more details about the &#39;why&#39=
;. &#39;configuring<br>
&gt; limits for a remote shared device&#39; doesn&#39;t justify the change.=
<br>
<br>
</div></div>This is to configure a bursty workload (and associated device) =
with<br>
known/allowed expected burst size, but to not allow full utilization<br>
of the device for extended periods of time for QoS. During idle or low<br>
use periods the burst allowance accrues, and then tasks can burst well<br>
beyond the configured throttle up to the limit, afterwards is<br>
throttled. A constant throttle speed isn&#39;t sufficient for this as you<b=
r>
can only burst 1 slice worth, but a limit of sorts is desirable for<br>
preventing over utilization of the shared device. This type of limit<br>
is also slightly different than what i understand io.low does in local<br>
cases in that tg is only high priority/unthrottled if it is bursty,<br>
and is limited with constant usage<br>
<br>
Khazhy<br>
</blockquote></div>Ping? Not sure if this was lost<br></div></div>

--001a11397b840eea24055fb52b9b--

--001a11397b841596ea055fb52b81
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
Gdp8HTY2MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCNo2qiPkk3+os7ueCLzKf6
QQepB6UJH9iIhE8al6zWfjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xNzEyMDcwMDMwMDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglg
hkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALY76UwsshCxZ9g2XTIPAHe0RKS98J48Yw/Uazrox
CFK+Pzdwi3SqOVgJbCvdfPGP6tGDXeV1SEqzWI6FDB5FVm4Agp/o+EWoIHXocZsdozVHyo5HkMfu
oneFgYY1z3IkZJrVhjkbpcI2Q2DGQBK2r+pRy4zaYfLzvdRMbcqK5lscFtMwwdQsaSP47BHzj2eh
uwOi8kIS0rIWa7lJYq7NgEFpo46AxY2jG43sMaFkurtIG83NWHKyspjXV74M/o2IDaOIYcA+WOe7
vDCxF5P/ncS2tAIQjW1qfwRysU1KwWbmQGnRs1HhxpecaPHwwUNhc8ucQYGwzLuEN0octtNu8A==
--001a11397b841596ea055fb52b81--
