Return-Path: <SRS0=qLSf=3R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D892C33CB3
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 14:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5482467E
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 14:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbgA1Oc0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:32:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58573 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgA1Oc0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jan 2020 09:32:26 -0500
Received: from 1.general.smb.uk.vpn ([10.172.193.28])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <stefan.bader@canonical.com>)
        id 1iwRuf-0000U8-Nr; Tue, 28 Jan 2020 14:32:21 +0000
Subject: Re: [PATCH 1/1] blk/core: Gracefully handle unset make_request_fn
To:     Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Tyler Hicks <tyler.hicks@canonical.com>,
        Alasdair Kergon <agk@redhat.com>
References: <20200123091713.12623-1-stefan.bader@canonical.com>
 <20200123091713.12623-2-stefan.bader@canonical.com>
 <20200123103541.GA28102@redhat.com> <20200123172816.GA31063@redhat.com>
 <81055166-37fb-ad65-6a53-11c22c626ab1@kernel.dk>
 <20200127193225.GA5065@redhat.com>
From:   Stefan Bader <stefan.bader@canonical.com>
Autocrypt: addr=stefan.bader@canonical.com; prefer-encrypt=mutual; keydata=
 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
 2Iat+yfjuNhlNAJs
Message-ID: <e0475dae-a55f-f30e-a82f-ee35cdb171c4@canonical.com>
Date:   Tue, 28 Jan 2020 15:32:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127193225.GA5065@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QoMqDKtowBAHCBPOeuuP2rKfGv2dipUh6"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QoMqDKtowBAHCBPOeuuP2rKfGv2dipUh6
Content-Type: multipart/mixed; boundary="HBI1GOJsjgBEKnldT5vqQi19oKb4RQWqA"

--HBI1GOJsjgBEKnldT5vqQi19oKb4RQWqA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.01.20 20:32, Mike Snitzer wrote:
> On Thu, Jan 23 2020 at  1:52pm -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
>=20
>> On 1/23/20 10:28 AM, Mike Snitzer wrote:
>>> On Thu, Jan 23 2020 at  5:35am -0500,
>>> Mike Snitzer <snitzer@redhat.com> wrote:
>>>
>>>> On Thu, Jan 23 2020 at  4:17am -0500,
>>>> Stefan Bader <stefan.bader@canonical.com> wrote:
>>>>
>>>>> When device-mapper adapted for multi-queue functionality, they
>>>>> also re-organized the way the make-request function was set.
>>>>> Before, this happened when the device-mapper logical device was
>>>>> created. Now it is done once the mapping table gets loaded the
>>>>> first time (this also decides whether the block device is request
>>>>> or bio based).
>>>>>
>>>>> However in generic_make_request(), the request function gets used
>>>>> without further checks and this happens if one tries to mount such
>>>>> a partially set up device.
>>>>>
>>>>> This can easily be reproduced with the following steps:
>>>>>  - dmsetup create -n test
>>>>>  - mount /dev/dm-<#> /mnt
>>>>>
>>>>> This maybe is something which also should be fixed up in device-
>>>>> mapper.
>>>>
>>>> I'll look closer at other options.
>>>>
>>>>> But given there is already a check for an unset queue
>>>>> pointer and potentially there could be other drivers which do or
>>>>> might do the same, it sounds like a good move to add another check
>>>>> to generic_make_request_checks() and to bail out if the request
>>>>> function has not been set, yet.
>>>>>
>>>>> BugLink: https://bugs.launchpad.net/bugs/1860231
>>>>
>>>> >From that bug;
>>>> "The currently proposed fix introduces no chance of stability
>>>> regressions. There is a chance of a very small performance regressio=
n
>>>> since an additional pointer comparison is performed on each block la=
yer
>>>> request but this is unlikely to be noticeable."
>>>>
>>>> This captures my immediate concern: slowing down everyone for this D=
M
>>>> edge-case isn't desirable.
>>>
>>> SO I had a look and there isn't anything easier than adding the propo=
sed
>>> NULL check in generic_make_request_checks().  Given the many
>>> conditionals in that  function.. what's one more? ;)
>>>
>>> I looked at marking the queue frozen to prevent IO via
>>> blk_queue_enter()'s existing cheeck -- but that quickly felt like an
>>> abuse, especially in that there isn't a queue unfreeze for bio-based.=

>>>
>>> Jens, I'll defer to you to judge this patch further.  If you're OK wi=
th
>>> it: cool.  If not, I'm open to suggestions for how to proceed. =20
>>>
>>
>> It does kinda suck... The generic_make_request_checks() is a mess, and=

>> this doesn't make it any better. Any reason why we can't solve this
>> two step setup in a clean fashion instead of patching around it like
>> this? Feels like a pretty bad hack, tbh.
>=20
> I just staged the following DM fix:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.=
git/commit/?h=3Ddm-5.6&id=3D28a101d6b344f5a38d482a686d18b1205bc92333

Thanks Mike,

yeah this looks like it resolves the problem without adding any impact on=
 the
generic I/O path. We certainly had thought about that but felt uncertain =
whether
it would not open other risks. Like something adding requests just before=
 the
table load. Could this cause some I/O be handled by one function and the =
rest by
another? And would that really matter?

The other thing that was a bit strange but maybe someone else's problem i=
s that
mount generated I/O requests to start with. The device size should be 0 s=
till.


>=20
> From: Mike Snitzer <snitzer@redhat.com>
> Date: Mon, 27 Jan 2020 14:07:23 -0500
> Subject: [PATCH] dm: fix potential for q->make_request_fn NULL pointer
>=20
> Move blk_queue_make_request() to dm.c:alloc_dev() so that
> q->make_request_fn is never NULL during the lifetime of a DM device
> (even one that is created without a DM table).
>=20
> Otherwise generic_make_request() will crash simply by doing:
>   dmsetup create -n test
>   mount /dev/dm-N /mnt
>=20
> While at it, move ->congested_data initialization out of
> dm.c:alloc_dev() and into the bio-based specific init method.
>=20
> Reported-by: Stefan Bader <stefan.bader@canonical.com>
> BugLink: https://bugs.launchpad.net/bugs/1860231
> Fixes: ff36ab34583a ("dm: remove request-based logic from make_request_=
fn wrapper")
> Depends-on: c12c9a3c3860c ("dm: various cleanups to md->queue initializ=
ation code")
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/md/dm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index e8f9661a10a1..b89f07ee2eff 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1859,6 +1859,7 @@ static void dm_init_normal_md_queue(struct mapped=
_device *md)
>  	/*
>  	 * Initialize aspects of queue that aren't relevant for blk-mq
>  	 */
> +	md->queue->backing_dev_info->congested_data =3D md;
>  	md->queue->backing_dev_info->congested_fn =3D dm_any_congested;
>  }
> =20
> @@ -1949,7 +1950,12 @@ static struct mapped_device *alloc_dev(int minor=
)
>  	if (!md->queue)
>  		goto bad;
>  	md->queue->queuedata =3D md;
> -	md->queue->backing_dev_info->congested_data =3D md;
> +	/*
> +	 * default to bio-based required ->make_request_fn until DM
> +	 * table is loaded and md->type established. If request-based
> +	 * table is loaded: blk-mq will override accordingly.
> +	 */
> +	blk_queue_make_request(md->queue, dm_make_request);
> =20
>  	md->disk =3D alloc_disk_node(1, md->numa_node_id);
>  	if (!md->disk)
> @@ -2264,7 +2270,6 @@ int dm_setup_md_queue(struct mapped_device *md, s=
truct dm_table *t)
>  	case DM_TYPE_DAX_BIO_BASED:
>  	case DM_TYPE_NVME_BIO_BASED:
>  		dm_init_normal_md_queue(md);
> -		blk_queue_make_request(md->queue, dm_make_request);
>  		break;
>  	case DM_TYPE_NONE:
>  		WARN_ON_ONCE(true);
>=20



--HBI1GOJsjgBEKnldT5vqQi19oKb4RQWqA--

--QoMqDKtowBAHCBPOeuuP2rKfGv2dipUh6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE2118yvOZTjOV2k0+6Gdd7svuzqMFAl4wRe4ACgkQ6Gdd7svu
zqN2qw//bBrpllkwHJsA1CMT6kaPx5+mSENn7s/AIdQpsTMTTkP7rKPJQq5mx0yz
ZGG5yfJWZYitxNlnhMBIYfc0HzZJt69tZ8lBmfdloit3Uj4rdODY2VQqcqXGQ1zw
gBdaCAyP3pRCAYRKk7TERNGXO6+Q/xQP6neEbbnWT9AwGL80YfwlEZmP+WAPq3im
D5eCn4/zAv+4GTA13YBhNjozdm/I2+TSsjVhDhLaU780bIXMnyatB82yltYYEbSb
Hwo0OxqHw5nZdoO9VgK5m1rraHMCWKKhErm7GzUFyO8zFpSUsfhv7hVucbQgXIIF
Se89YPf+q2um1Yz77F1SkzVvLh3/rDRw3ACFSoAo1d22nXC02EfwASdvGw9OlJIz
+ffi0DVY9nUyaVXKz7f+C3FxwzldWMvNmrgoteLjNJ3jJ5Of0jBIq/nwxqTDVrny
oZ3el+F8VzUkuf5Nx8buYarX1ov1M1as/qlE9jlVGTzK63mgC9OOKEyn60+luUyf
hsZjQFrOncc3a8yhW82nyushl3pxdj93N55XdYEKHeikPTeLKd61TKKx0j0Pty2k
gT+ZiH3UjHLEZJAPbc94F6q3r1nh+q8KvUDRKjMbMz5B8IfZl9Cco3BxAYEpH/cf
mC+PnV1xFOMkwJZSwyLHl4bwf02sTMG+aPBVZiZyXqQNOGHr8XU=
=W0r0
-----END PGP SIGNATURE-----

--QoMqDKtowBAHCBPOeuuP2rKfGv2dipUh6--
