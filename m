Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA4AC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 15:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752552087F
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 15:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfA1PHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:07:51 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:46559 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfA1PHv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 10:07:51 -0500
Received: by mail-pl1-f174.google.com with SMTP id t13so7838567ply.13;
        Mon, 28 Jan 2019 07:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GZymkRRiMHKeiCCBe/BtgL9hFN3UVH4WZYxF8vYG65g=;
        b=fPx0Oc1rFERnt4Gyblr78LynA5R+abRF3K4eueT8xfXMrBg8WolxyV3EeSvBQgiDw2
         7kN5hwPdghsUe5FGG9L2zlPWa+Sr4U/AiSR+XjqbkXZC6fWnhnijyU/CPABnJGxRFDmy
         GaKG7bzZZs5QIMc1Z/wXyy0uc5PO/u1PEFe3AZTQEFyNQVo0LBIlvjCSnthO3P0Mq5fX
         Oe417Euo4b6Nono/kHIkM7dp4zLZbYGtEIvkLOxjsdhvavmXYtJXmKpxZKRDG3duL6rU
         HzqAAreNVYDAGHKwFSgkfWqJpAMP5MOa2EGz4/4zYy5VEhvpf2SUjUXP7TUHUumkIKhi
         VnSA==
X-Gm-Message-State: AJcUukdvfky1DhmSiaC8+nlX3U8596TRokO7yEU4Q6dckr1Ah0hhmEHI
        0urY7bQep65YaIrai9CRA6g=
X-Google-Smtp-Source: ALg8bN60rSaZLrgV4SzQqnaedKSFHXkLvjO+IFErArO8taR7eFLXvl/QVGRWfJROfeg0KSMqjGdwTw==
X-Received: by 2002:a17:902:848f:: with SMTP id c15mr15423247plo.119.1548688070649;
        Mon, 28 Jan 2019 07:07:50 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id h74sm49379453pfd.35.2019.01.28.07.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 07:07:49 -0800 (PST)
Subject: Re: [LSF/MM TOPIC] Zoned Block Devices
To:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <714fc666-c562-83c2-c1a3-19f1dd47d1d9@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4adb1038-246a-530a-5265-1d16d0cd5014@acm.org>
Date:   Mon, 28 Jan 2019 07:07:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <714fc666-c562-83c2-c1a3-19f1dd47d1d9@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 4:56 AM, Matias Bjorling wrote:
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
> valuable in the kernel? If the interface is successful, we would expect
> the interface to move to ATA/SCSI for standardization as well.

Hi Matias,

This topic proposal sounds interesting to me, but I think it is 
incomplete. Shouldn't it also be discussed how user space applications 
are expected to submit "zone append" writes? Which system call should 
e.g. fio use to submit this new type of write request? How will the 
offset at which data has been written be communicated back to user space?

Thanks,

Bart.
