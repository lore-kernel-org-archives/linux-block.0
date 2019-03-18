Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D65BC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6085E2133F
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="0RipUmDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCRTWB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:22:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39304 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCRTWB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:22:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so14532231edc.6
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 12:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=GqC6aYXfiLJqijCrQOvR7eQags13+n4+A3dDDrz+hWA=;
        b=0RipUmDYOXY0cEh0ZkqyelQpdIC+7zCVXaIeUHrq/phAp28DVuQk5X9uT8Bv0CIsy1
         W/4l38wGBEW1a71Ac1QGdd19iGTVTYppU9JL7X0KhaH1w77QxUfoDlbzir7Q8Q/tyPiT
         cIOI+CfofITN7Tao0EQcBUQZRu31reXIZ31UiToXVr+X7YQ4v//55YKWeLbPO+995c1z
         V9WqNw2n204Lm5LK0INV7KYHZFKUUbIv8BMr2tGs9MHwkGtrrIgKU7CBKVS7Hxnj+3pQ
         YVAnYCtp1dD2tsyJGHqBbNJGEqrwpcLZXhOJupujq0mP/ZcfH3HhcxoTjcBwc208olHg
         WmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=GqC6aYXfiLJqijCrQOvR7eQags13+n4+A3dDDrz+hWA=;
        b=nTubwCgVs3aDIi+Gg1Ork51hyreJtXqKBW8wLOXl6lR+cW3IcDbmqwkVCRJOYhElW2
         rbmSB50HvycDZKF4eWbu74kj7iRCdIM1YlZZ6VMqoRe3Wf/Ec/XsOsV7xcLWfkpFvDV4
         89JnaVVWLMlCjMPO3mlzxdHBd8pPIPXmLXwYzRXXBfN2SJDDyamn1CMyNrufJKs95MFS
         wp2gKKcW4oYLoXvIxYalNsLM14Euv0PrGbwyWyvxmjsqgjmBKVkfcueBf0cGXW21chNe
         fabW1k2Ztu43KWVL5ml5Kr7QDgqmim64EWoGDkhugZED4KhDRuhFOwHGa/ohzIFu80c+
         seBQ==
X-Gm-Message-State: APjAAAUGQXuZXdDN0LuL5FMJEXRvAUGW5AEdRTRgurkfhnRSO+NTc1ni
        KXqt3qcczBa9GJOGVmC/b9o3Z+B988/eCA==
X-Google-Smtp-Source: APXvYqzJkFSNgK8l2Pm4GX/NfKOsEkbLQQP8t/9v0rrJRH767ql6VI5F4v67HrvSF8FdDwg3yRMORA==
X-Received: by 2002:a50:9284:: with SMTP id k4mr7482828eda.216.1552936919044;
        Mon, 18 Mar 2019 12:21:59 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id o12sm3202402edt.58.2019.03.18.12.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 12:21:58 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <0983C3F3-0141-43B4-A97D-A4ACB797E4D0@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_CB2C9921-9D71-4DBE-A47B-62A93129ABF9";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 15/18] lightnvm: pblk: fix in case of lack of lines
Date:   Mon, 18 Mar 2019 20:21:57 +0100
In-Reply-To: <b6536c70-2593-7751-de3d-beba51dad092@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-16-igor.j.konopko@intel.com>
 <FFE27E31-83ED-41CB-9D6C-327C3E3BA7D9@javigon.com>
 <b6536c70-2593-7751-de3d-beba51dad092@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_CB2C9921-9D71-4DBE-A47B-62A93129ABF9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 18 Mar 2019, at 14.28, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
>=20
>=20
> On 18.03.2019 08:42, Javier Gonz=C3=A1lez wrote:
>>> On 14 Mar 2019, at 17.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>>>=20
>>> In case when mapping fails (called from writer thread) due to lack =
of
>>> lines, currently we are calling pblk_pipeline_stop(), which waits
>>> for pending write IOs, so it will lead to the deadlock. Switching
>>> to __pblk_pipeline_stop() in that case instead will fix that.
>>>=20
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-map.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-map.c =
b/drivers/lightnvm/pblk-map.c
>>> index 5408e32..afc10306 100644
>>> --- a/drivers/lightnvm/pblk-map.c
>>> +++ b/drivers/lightnvm/pblk-map.c
>>> @@ -46,7 +46,7 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
>>> 		pblk_line_close_meta(pblk, prev_line);
>>>=20
>>> 		if (!line) {
>>> -			pblk_pipeline_stop(pblk);
>>> +			__pblk_pipeline_stop(pblk);
>>> 			return -ENOSPC;
>>> 		}
>>>=20
>>> --
>>> 2.9.5
>> Have you seeing this problem?
>> Before checking if there is a line, we are closing metadata for the
>> previous line, so all inflight I/Os should be clear. Can you develop =
on
>> the case in which this would happen?
>=20
> So we have following sequence: pblk_pipeline_stop() -> =
__pblk_pipeline_flush() -> pblk_flush_writer() -> wait for emptying =
round buffer.
> This will never complete, since we still have some RB entries, which =
cannot be written since writer thread is blocked with waiting inside =
pblk_flush_writer().
>=20
> Am I missing sth?

So this will be the case in which we are in the last line and
pblk_flush_writer() needs to allocate an extra line persist the write
buffer? Shouldn=E2=80=99t the rate-limiter take care of this? As I =
recall, Hans
implemented some logic to guarantee that at least one line is always
available for GC, which in turn will free a line for user data. When we
hit this limit, performance will drop dramatically, but it should not
stall.

The reason I want to understand the real case behind this fix is that by
calling __pblk_pipeline_stop() we are basically stopping all other
inflight I/Os; we should be able to serve all inflight I/Os before a
mapping error triggers the pipeline to get into read-only mode.

--Apple-Mail=_CB2C9921-9D71-4DBE-A47B-62A93129ABF9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyP79UACgkQPEYBfS0l
eOAwcQ//UQsPIto/3cEr+L6bLIBrvQC8adfv7mT81byNSuVaEIkPzCHeA1nwppFg
BX8yNvs+kdSAAS3I88+zAgfUZJEmmLmoA8UMIWZUUyryKX6TaftILlufKWf+wUG5
8o2A0h2sntH7as9en/dD5RLV8C79jNcO+lFIJUVtlyo5tB1jZD4YVSZtSWH69O0m
U7Doy8DW2B0qpHFSFfm196Sz6gjToA9CkImUNVlTNW0dVWtRkxZPIZqxEjsC15qt
D4/OiBiVlV8UX5J7M7Wxoyhr5BablSqLG4C9Zbbk26UHRV8eMGwAPd7qgpR6sTec
SEjtephUPetkNMBtk38zWOZOebNEnH9i22kYwbNrRC+liyXI8UsRjKeMI/yDLR/W
RCvg4178znAKbWDsgIbz3GqF8RvexJMHfdh/grlEpjLNDj6vmM9ybC1RGBqyTAYq
5ZBEC0/w822rlIZ6y7f7VABpSRABQIUqHKxFQJZ0+mB2CNeQn6/KH7BLBtEeBUql
247U+MNbKyTMpYCDOSVLeMxFesxUbouN9P3KzxRQaWSIXZuilDjv//4dEaG5L3Z2
rkDU0iTlftjJa2Vm8WFEbUwmp9ct6khtJYCMJRi8WmPcPqBMKyL9C0I1BKo3XoDA
+eEb6tEHzqMh5mt/aaGiapgIniKrDXP8pHKregU2rm+GnYQPPs8=
=UuoV
-----END PGP SIGNATURE-----

--Apple-Mail=_CB2C9921-9D71-4DBE-A47B-62A93129ABF9--
