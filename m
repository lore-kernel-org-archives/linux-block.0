Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDBCC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 14:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF6620835
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 14:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="2Mwjp+kn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCDOGe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:06:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47040 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCDOGe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 09:06:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id f2so4324324edy.13
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 06:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AL6A9wplAFszVS+FgKNbfwFSi81YuBwQ3MmDG4AprHk=;
        b=2Mwjp+knUWz0vmEPQpd522bi6aUxSaQpXED8y/9RdDlEa0vKj+lN+z9kgGJxYW+af7
         tpXB/QgKsUJj9q3VbFfTDCM3u5uaZNP1l1rj1DqOLsGpHhpHoMH9j0MwTAH4iDQLZmYx
         tALuRm3D5nuwOzQS/dHE21b90w0g5Rh1HGipqSJGr62DCcolv9sxicfGY9vuzi3woO5J
         qGHCQAUGoGGgXKx7trFbYJBu9ZBGdTDRwQnF8mZ9T1dZwSKBGqPfRVZerIV2gitOU2Ss
         2s89bW+rkaBCGvfmFIfUSjE5H27t5ITzd25luG2b3t4upvioqtAWt2v/OV3XwUOq1amY
         1tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AL6A9wplAFszVS+FgKNbfwFSi81YuBwQ3MmDG4AprHk=;
        b=IBxx0sZQG17s1US6/VYEicU476yel186H9zj/aP5/DwsTKoXFsZr/AoSThvdEjfi/k
         t21+cwoofgQy7zNtK3GqQ1jNN8x50x1ZZXMpAtD15uf5GXbrFXyGSV1KJHwSIiHcRxah
         DVF6Fk19PN2CEFyfYGjZl+dZQDf91fLvIcb4REgFubAjS29a/74ejyys2Q3SPqqryYq+
         f+e31qzgSB/NGjGQoeV+xhMYPED1I5s6FJxqkEttyp7ZqvkauRtTLd75hhBZtc7qAxgn
         9mRmU7VTRQrepQcnyiz3ZPXoAY/qzygQ+wLiiA1Yf/HiUam80Rjh09kxR7LrLoaJ+X3F
         e2rg==
X-Gm-Message-State: APjAAAVShInm09CXZUBtTormIKMrCWnKScr/+UZCO6qUtYGKoke6S7Xd
        dVVl9ryF7SbiUhAjAZ7ZIHwW8g==
X-Google-Smtp-Source: APXvYqzsCduCztU+WPlLeix5XUyoRmheJ4tFbzf2Y906Tx6LfrZB3R64Au2mLli0BgsYgyQoKg2CKg==
X-Received: by 2002:a05:6402:1490:: with SMTP id e16mr15287191edv.201.1551708392693;
        Mon, 04 Mar 2019 06:06:32 -0800 (PST)
Received: from [192.168.1.134] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id q24sm2107296edg.20.2019.03.04.06.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 06:06:32 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 13/13] lightnvm: Inherit mdts from the parent nvme device
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <3d053281-ef87-66e3-3433-de4c18884326@intel.com>
Date:   Mon, 4 Mar 2019 15:06:31 +0100
Cc:     Hans Holmberg <hans@owltronix.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Simon Andreas Frimann Lund <slund@cnexlabs.com>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4702ADD0-692C-4F46-817E-508A0403D98F@javigon.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com> <20190227171442.11853-14-igor.j.konopko@intel.com> <2776B2AC-19D2-4E38-94AD-E158E3E60A37@javigon.com> <CANr-nt2dNY8EgeJ7qAutfVEuyose_8_j9w6WkO-mER-Ao6oXOg@mail.gmail.com> <54D42A19-96EE-4370-B957-A474BB912530@javigon.com> <CANr-nt1zQWf8XkQaesyFO+wTLULdEAvATvYjYFiDXbc_vifKGQ@mail.gmail.com> <3d053281-ef87-66e3-3433-de4c18884326@intel.com>
To:     Igor Konopko <igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On 4 Mar 2019, at 14.04, Igor Konopko <igor.j.konopko@intel.com> wrote:
>=20
>=20
>=20
>> On 04.03.2019 13:22, Hans Holmberg wrote:
>>> On Mon, Mar 4, 2019 at 12:44 PM Javier Gonz=C3=A1lez <javier@javigon.com=
> wrote:
>>>=20
>>>=20
>>>=20
>>>> On 4 Mar 2019, at 12.30, Hans Holmberg <hans@owltronix.com> wrote:
>>>>=20
>>>> On Mon, Mar 4, 2019 at 10:05 AM Javier Gonz=C3=A1lez <javier@javigon.co=
m> wrote:
>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wro=
te:
>>>>>>=20
>>>>>> Current lightnvm and pblk implementation does not care
>>>>>> about NVMe max data transfer size, which can be smaller
>>>>>> than 64*K=3D256K. This patch fixes issues related to that.
>>>>=20
>>>> Could you describe *what* issues you are fixing?
>=20
> I'm fixing the issue related to controllers which NVMe max data transfer s=
ize is lower that 256K (for example 128K, which happens for existing NVMe co=
ntrollers and NVMe spec compliant). Such a controllers are not able to handl=
e command which contains 64 PPAs, since the the size of DMAed buffer will be=
 above the capabilities of such a controller.
>=20

OK. Then let=E2=80=99s try to get support for this ASAP. If the rest agree o=
n a feature bit then it should be straightforward. If not, let=E2=80=99s at l=
east add a warning if MDTS < 64 so that people are able to identify where th=
e missing performance went when updating the kernel if they are not using MD=
TS on their OCSSD implementations.=20

Javier
