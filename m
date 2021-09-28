Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0E2C433F5
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 18:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDC36124B
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 18:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbhI1SIy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:08:54 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:43809 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbhI1SIx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 14:08:53 -0400
Received: by mail-pg1-f173.google.com with SMTP id r2so22048615pgl.10
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 11:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GOStBCU5BUDg+akKKgzAUjrvZAyr5MYSziH+igz58jM=;
        b=orqW1nbqgxfgGxYhSt2LsXpLFKlTa6K7HktjwmRmIgVBdY+pj1WO3o1pPSnvFBm42p
         JSl5BgPA+PpGNKcnhFQvFtJ1uU8uiYdYrEPRcXcMAGx62fD6j2H0dbKJwsihcgDNtTM6
         nELAHwQV9qaNFbZLr2LueDNyh8mCNnL6atjQ9FhK0ZyLmea/OjxhWI2tRdedeQe18PWL
         tr/J97RHUSC9ayZOCfOgRWJVUWxgfzP0fhN36/Q3k8qjJHIQpMCGT1QeGJHu+s9MwYC/
         mBbIakunid50sHrOCHFbGcAf+DSh5w2/IXYr1pbxbdedmXp/4lKzqBM2D5Ou15mih7zi
         1Sbg==
X-Gm-Message-State: AOAM530pyDYm9yt2BUJeGF/eAO1nxyqyhVDuPX7Xp2xVDwUayuEaoArr
        jbpz4w3zFxZ9xMQoWaUg+NJQx8BK9ss=
X-Google-Smtp-Source: ABdhPJyOogr8ih1J+STBoQXA00qLgDh4fGP1T/3SD9iuWE1gWT67TY0RquamzoEM2PnlebWONz0eKQ==
X-Received: by 2002:aa7:9832:0:b0:44b:232a:a15d with SMTP id q18-20020aa79832000000b0044b232aa15dmr6902440pfl.51.1632852433339;
        Tue, 28 Sep 2021 11:07:13 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3e98:6842:383d:b5b2])
        by smtp.gmail.com with ESMTPSA id c12sm20954911pfc.161.2021.09.28.11.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 11:07:12 -0700 (PDT)
Subject: Re: [bug report] blktests srp/013 lead kernel panic with latest
 block/for-next and 5.13.15
To:     Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Laurence Oberman <loberman@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>
References: <CAHj4cs8XNtkzbbiLnFmVu82wYeQpLkVp6_wCtrnbhODay+OP9w@mail.gmail.com>
 <059007be-03fa-5948-d86d-d1750587e894@acm.org>
 <c5db85b3ecb9730d848b2c37c975b72acd8a2413.camel@redhat.com>
 <CAHj4cs_8KbMJ+HU22E4-e_zYuPj8TfGOzxNtzQqxqKig9S=gQg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <491cab4b-1f5b-2881-5ba2-943c23d407ff@acm.org>
Date:   Tue, 28 Sep 2021 11:07:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs_8KbMJ+HU22E4-e_zYuPj8TfGOzxNtzQqxqKig9S=gQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/21 10:10 PM, Yi Zhang wrote:
> Hi Bart
> 
> Bisect shows this issue was introduced from bellow commit, btw, this is always reproduced on the s390x kvm environment:
> 
> commit 65ca846a53149a1a72cd8d02e7b2e73dd545b834
> Author: Bart Van Assche <bvanassche@acm.org <mailto:bvanassche@acm.org>>
> Date:   Wed Jan 22 19:56:34 2020 -0800
> 
>      scsi: core: Introduce {init,exit}_cmd_priv()
> 
>      The current behavior of the SCSI core is to clear driver-private data
>      before preparing a request for submission to the SCSI LLD. Make it possible
>      for SCSI LLDs to disable clearing of driver-private data.
> 
>      These hooks will be used by a later patch, namely "scsi: ufs: Let the SCSI
>      core allocate per-command UFS data".
> 
> (gdb) l *(scsi_mq_exit_request+0x2c)
> 0x8d7be4 is in scsi_mq_exit_request (drivers/scsi/scsi_lib.c:1780).
> 1775 unsigned int hctx_idx)
> 1776 {
> 1777 struct Scsi_Host *shost = set->driver_data;
> 1778 struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
> 1779
> 1780 if (shost->hostt->exit_cmd_priv)
> 1781 shost->hostt->exit_cmd_priv(shost, cmd);
> 1782 kmem_cache_free(scsi_sense_cache, cmd->sense_buffer);
> 1783 }
> 1784

Hi Yi,

Thank you for having taken the time to run a bisect. However, I strongly doubt
that the bisection result is correct. If there would be anything wrong with the
above patch it would already have been noticed on other architectures. I
recommend to proceed as follows:
* Verify whether the reported issue only occurs with the stable kernel series or
   also with mainline kernels.
* Work with the soft-iWARP author to improve the reliability of the siw driver.
   If I run blktests in an x86 VM then the following appears sporadically in
   the kernel log:

------------[ cut here ]------------
WARNING: CPU: 18 PID: 5462 at drivers/infiniband/sw/siw/siw_cm.c:255 __siw_cep_dealloc+0x184/0x190 [siw]
CPU: 1 PID: 5462 Comm: kworker/u144:13 Tainted: G            E     5.15.0-rc2-dbg+ #7
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: iw_cm_wq cm_work_handler [iw_cm]
RIP: 0010:__siw_cep_dealloc+0x184/0x190 [siw]
Call Trace:
  siw_cep_put+0x5c/0x80 [siw]
  siw_reject+0x13c/0x230 [siw]
  iw_cm_reject+0xac/0x130 [iw_cm]
  cm_conn_req_handler+0x4f1/0x7d0 [iw_cm]
  cm_work_handler+0x885/0x9c0 [iw_cm]
  process_one_work+0x535/0xad0
  worker_thread+0x2e7/0x700
  kthread+0x1f6/0x220
  ret_from_fork+0x1f/0x30
irq event stamp: 11449266
hardirqs last  enabled at (11449265): [<ffffffff81fc4248>] _raw_spin_unlock_irq+0x28/0x50
hardirqs last disabled at (11449266): [<ffffffff81fb7e44>] __schedule+0x5f4/0xbb0
softirqs last  enabled at (11449176): [<ffffffffa06d142f>] p_fill_from_dev_buffer+0xff/0x140 [scsi_debug]
softirqs last disabled at (11449168): [<ffffffffa06d1400>] p_fill_from_dev_buffer+0xd0/0x140 [scsi_debug]
---[ end trace b23871487c995b72 ]---

* Use the rdma_rxe driver to run blktests since at least in my experience that
   driver is more reliable than the soft-iWARP driver.

Thanks,

Bart.
