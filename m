Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D4BC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 21:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D5220663
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 21:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="aXjJ5Tzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfBGVMW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:12:22 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43908 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfBGVMW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 16:12:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so1052043eds.10
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 13:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3OME255Bf/uxB/3SsI2f37qTGiqhn3cF46//e7/7eVM=;
        b=aXjJ5Tzwh+JKJQi+wozKXYNGLa4+PvyuxjoYFE7gmYZKf8GKMjTGzFE6SNN0PpM6Mp
         6Sn93mrCqP1o/w58ktLo8ch9IfTdRN098Fk4BsxaNq4+uac6SVFZB0TD8ShZARC+hfAa
         gG3sjWz5vPHwWesu/AnTrJvez0utQltPlYlrPWE82hg+/DDVAnPVZ1BgCMf971ycorEC
         WI8CK/mJ4XpgsmekliZwJH4ZKM62mLnZnukRilJtlcGv7WUs0BCEwE+L9qW9ZrjSDbGq
         mXLPQVHT24umxnfcnKgB3Swl9XnOhjTdDYwHiInjwi+MOsAjc06Ry2EmBhbV1dwt15ya
         acow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3OME255Bf/uxB/3SsI2f37qTGiqhn3cF46//e7/7eVM=;
        b=c2Ho7DbjBQ6GMVdh92Md4rE/q/akkyd0mnUVmO8gRJZ6HfV5rz4nSw7MXcRqZisnnv
         o1RhvUKXg3gQaM+HldNrqFeBPpZtqLv1qdcP2V9Mob+7qrZUXmZvyhDV8odG2L3m+Gmm
         KhEuFZfvH0mWsn07+pEjDz/TFZiqhUgSWzRZHVFeuSQ+gW80k4QzO/1U7xDea5TaQkNL
         VnuctBy88qnGFqvrPRgB60jQYn3d+iO9vVZbUl8Z+Efy6YO4e7PTycX+H2u5oDSODF0e
         oYktMcPwhxA8DoCcu3i2Pb7wcTPDId98MNRFFop01bkK7Cvs3TraIBmvL2snNFm9lcwa
         OX3g==
X-Gm-Message-State: AHQUAubv+K7s2LsrbaJxOSt7MEKgRzdCxqUzUjBT24l7Zelf4JO16ZX7
        62HbnPmwv2B4IB2Tkt2r3gp9oQ==
X-Google-Smtp-Source: AHgI3IZbcG80nPcvIKfmajw5SYcVA2Ll7XmgZuv3K3KMz3pRJI6mg6EpMQCqNU8oYloJjWif5ympgQ==
X-Received: by 2002:a17:906:a44:: with SMTP id x4-v6mr13083856ejf.177.1549573939763;
        Thu, 07 Feb 2019 13:12:19 -0800 (PST)
Received: from [192.168.1.143] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id l17sm101722edc.56.2019.02.07.13.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 13:12:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [LSF/MM TOPIC] BPF for Block Devices
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
In-Reply-To: <04952865-6EEE-4D78-8CC9-00484CFBD13E@javigon.com>
Date:   Thu, 7 Feb 2019 22:12:17 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6ABE829-3F3F-4612-943E-4899D91CEB1D@javigon.com>
References: <40D2EB06-6BF2-4233-9196-7A26AC43C64E@raithlin.com>
 <04952865-6EEE-4D78-8CC9-00484CFBD13E@javigon.com>
To:     Stephen Bates <sbates@raithlin.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+ Mailing lists

> On 7 Feb 2019, at 18.48, Javier Gonz=C3=A1lez <javier@javigon.com> =
wrote:
>=20
>=20
>=20
>> On 7 Feb 2019, at 18.12, Stephen Bates <sbates@raithlin.com> wrote:
>>=20
>> Hi All
>>=20
>>> A BPF track will join the annual LSF/MM Summit this year! Please =
read the updated description and CFP information below.
>>=20
>> Well if we are adding BPF to LSF/MM I have to submit a request to =
discuss BPF for block devices please!
>>=20
>> There has been quite a bit of activity around the concept of =
Computational Storage in the past 12 months. SNIA recently formed a =
Technical Working Group (TWG) and it is expected that this TWG will be =
making proposals to standards like NVM Express to add APIs for =
computation elements that reside on or near block devices.
>>=20
>> While some of these Computational Storage accelerators will provide =
fixed functions (e.g. a RAID, encryption or compression), others will be =
more flexible. Some of these flexible accelerators will be capable of =
running BPF code on them (something that certain Linux drivers for =
SmartNICs support today [1]). I would like to discuss what such a =
framework could look like for the storage layer and the file-system =
layer. I'd like to discuss how devices could advertise this capability =
(a special type of NVMe namespace or SCSI LUN perhaps?) and how the BPF =
engine could be programmed and then used against block IO. Ideally I'd =
like to discuss doing this in a vendor-neutral way and develop ideas I =
can take back to NVMe and the SNIA TWG to help shape how these standard =
evolve.
>>=20
>> To provide an example use-case one could consider a BPF capable =
accelerator being used to perform a filtering function and then using =
p2pdma to scan data on a number of adjacent NVMe SSDs, filtering said =
data and then only providing filter-matched LBAs to the host. Many other =
potential applications apply.=20
>>=20
>> Also, I am interested in the "The end of the DAX Experiment" topic =
proposed by Dan and the " Zoned Block Devices" from Matias and Damien.
>>=20
>> Cheers
>>=20
>> Stephen
>>=20
>> [1] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/net/ethernet/netronome/nfp/bpf/offload.c?h=3Dv5.0-rc5
>=20
> Definitely interested on this too - and pleasantly surprised to see a =
BPF track!
>=20
> I would like to extend Stephen=E2=80=99s discussion to eBPF running in =
the block layer directly - both on the kernel VM and offloaded to the =
accelerator of choice. This would be like XDP on the storage stack, =
possibly with different entry points. I have been doing some experiments =
building a dedup engine for pblk in the last couple of weeks and a =
number of interesting questions have arisen.
>=20
> Also, if there is a discussion on offloading the eBPF to an =
accelerator, I would like to discuss how we can efficiently support data =
modifications without having double transfers over either the PCIe bus =
(or worse, over the network): one for the data computation + =
modification and another for the actual data transfer. Something like =
p2pmem comes to mind here, but for this to integrate nicely, we would =
need to overcome the current limitations on PCIe and talk about p2pmem =
over fabrics.
>=20
> Javier

