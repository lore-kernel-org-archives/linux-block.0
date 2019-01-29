Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD3DC282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB012177E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Vq33moRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfA2IZW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:25:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36387 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfA2IZW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 03:25:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so15263979edb.3
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 00:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=9xuYWDi7d9dJvDGS2rp/GcOgobQodqeglNUzIHz9zSQ=;
        b=Vq33moRIuX+ORtom1csCzGOE4BubSpR2Wnrq5WwxmCgomek6Ggw5XJvIEV3btF7MG2
         DFTpYlk7qfbK7rmpPpzmEuQeYGlTbt8wC7wRGdiYGpJYIb4WaVE+R3SpRgYNlTp9rM05
         hjl9zJgsxa9fPsibpw4NJfro4caAFOXGowfIXXH0DtJQj84oUOkYrZXWqmTqTksL9i9/
         W+1dJOPFn2YAuQPGJKrwsUXaC326h4K81jbSFHunGuIwQNnL+tEnSZ8OLIPrKpB1VO58
         lFfgtbnz2tj3OWxhE9x5F13pnKc4zK2NaKF3UBp+RjXWsHjCHK3agwKfzLujj43ftKFe
         uSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=9xuYWDi7d9dJvDGS2rp/GcOgobQodqeglNUzIHz9zSQ=;
        b=CT39FzUh6DSRst8O9BxVYx32p4eHvmGRieH9njHf3f7n/17S59eIRnuXhKLXmLAYxv
         4CpjQ0IBIMdMd5pYfHKuZG8dgSpnwvJiMJJqpBU7k9dsKpoXjRh4IqIGo7s8cqin4fog
         rjANLTfrWlgQgaWDx69I2liEyqHPPfrhAca80iCtW0y9PxQB+277TG0DRc2y7K6w6pS9
         GQ/DnR3jhS0ygMinx9ZPO+CHV4Mo1yTIuVpzBS9l1qEDcvwaAPKDJZXPtCpTw2doh1bU
         OkDeatFJUIajw/KJpSiiYrDBXNiumjb26l4LD+L6Dl9Kphm+dxwRYYxCeH4hk1bublND
         Tc9g==
X-Gm-Message-State: AJcUukeCTc84VlGuVmToRaBIfEwg3dci97qQW3+kynVSR6wU6Iw4MZUo
        10oUE5ULfHoDj1PNk+WIfL0eng==
X-Google-Smtp-Source: ALg8bN74KnTmGGPhvLOQxmIlalWSBNlA/6hy9WoFHWJQShODCTDZ3/EJR9EstR8mkGU3rSDi2G5qUQ==
X-Received: by 2002:a05:6402:758:: with SMTP id p24mr25181061edy.92.1548750319623;
        Tue, 29 Jan 2019 00:25:19 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id b14sm13700541edt.6.2019.01.29.00.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:25:19 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <F88F3B28-4CC8-4B54-AE2F-341936C0C184@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_A05E1982-0607-4647-86D2-553E122D7A54";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [LSF/MM TOPIC] Zoned Block Devices
Date:   Tue, 29 Jan 2019 09:25:17 +0100
In-Reply-To: <714fc666-c562-83c2-c1a3-19f1dd47d1d9@wdc.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Matias Bjorling <Matias.Bjorling@wdc.com>
References: <714fc666-c562-83c2-c1a3-19f1dd47d1d9@wdc.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_A05E1982-0607-4647-86D2-553E122D7A54
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

> On 28 Jan 2019, at 13.56, Matias Bjorling <Matias.Bjorling@wdc.com> wrote:
> 
> Hi,
> 
> Damien and I would like to propose a couple of topics centering around
> zoned block devices:
> 
> 1) Zoned block devices require that writes to a zone are sequential. If
> the writes are dispatched to the device out of order, the drive rejects
> the write with a write failure.
> 
> So far it has been the responsibility the deadline I/O scheduler to
> serialize writes to zones to avoid intra-zone write command reordering.
> This I/O scheduler based approach has worked so far for HDDs, but we can
> do better for multi-queue devices. NVMe has support for multiple queues,
> and one could dedicate a single queue to writes alone. Furthermore, the
> queue is processed in-order, enabling the host to serialize writes on
> the queue, instead of issuing them one by one. We like to gather
> feedback on this approach (new HCTX_TYPE_WRITE).
> 
> 2) Adoption of Zone Append in file-systems and user-space applications.
> 
> A Zone Append command, together with Zoned Namespaces, is being defined
> in the NVMe workgroup. The new command allows one to automatically
> direct writes to a zone write pointer position, similarly to writing to
> a file open with O_APPEND. With this write append command, the drive
> returns where data was written in the zone. Providing two benefits:
> 
> (A) It moves the fine-grained logical block allocation in file-systems
> to the device side. A file-system continues to do coarse-grained logical
> block allocation, but the specific LBAs where data is written and
> reported from the device. Thus improving file-system performance. The
> current target is XFS but we would like to hear the feasibility of it
> being used in other file-systems.
> 
> (B) It lets host issue multiple outstanding write I/Os to a zone,
> without having to maintain I/O order. Thus, improving the performance of
> the drive, but also reducing the need for zone locking on the host side.
> 
> Is there other use-cases for this, and will an interface like this be
> valuable
> in the kernel? If the interface is successful, we would expect the
> interface to move to ATA/SCSI for standardization as well.
> 
> Thanks, Matias

This topic is of interest to me as well.

For the append command, I think we also need to discuss the error model
as writes should be able to fail (e.g., a zone has shrink due to
previous, hidden, write errors and the host has not updated the zone
metadata).

Thanks,
Javier

--Apple-Mail=_A05E1982-0607-4647-86D2-553E122D7A54
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxQDe0ACgkQPEYBfS0l
eOC7cA/8CgVcrBtjQJob9IWvamrZQuBKQ6wirZ/QZPmqZfpKMjNvP0dR6hoO78D6
QN5p7swc5y9YP1ItzcHd3dHLjmPp8pCNH3fxb3FcS+6Kk67hiD9IcqMC2EiiGR+G
c0BFlfP8FdBYZNHoQn6GxdinOAy1E/djsa0FjMIZEEz+O8914a4tpJUmu6OrxCYE
XTNP8BMCAQAf3lCiU+MWeiMTPHcYSPSZP/5KxajDG8KYG9KSO4DuaFDNQ14vwlQt
kANKjd05x9Zb+VHJgaqzS1UV2uH6MtGq3hldefSBZm2sC06c9WxDZ4rTChFEq0Ws
Tw0KFzcH0L9nJrQqCpYnmXwXkK0cZkRqHKtqteDAa0eHIA8IBJ/AAAjV/DKq0CDW
vyJjZIzN0huaGBbwSrOOoAiDWude4XOf5UfuL/saBq+mNz20KAXoflO0GsCXaFYF
Q6lFKQCJ66inTB+AURFcJghpN2JFV89NOqghwVUDO/Bfdo1kdH7WhQxyjqGKLOlR
xb/zJRrE4ZiqRxlh4iaQBJbhH9DRyXnjOxQvrhP4FnalRo3gUqvVIV4N02Rh0Bdq
2WWnKgxtRZ97R3nDGtsSWSKd7LUJcyMSWwsTkEX4R26zmz3LlWxEFroCdC7mGN/u
Sfh6YbdBWJP3hc0VqlK2IUMiMzYtWg0GCyoqwxX6RkPEtV8rig8=
=M+qM
-----END PGP SIGNATURE-----

--Apple-Mail=_A05E1982-0607-4647-86D2-553E122D7A54--
