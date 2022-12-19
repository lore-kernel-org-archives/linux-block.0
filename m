Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F18C4332F
	for <linux-block@archiver.kernel.org>; Mon, 19 Dec 2022 17:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiLSRxF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Dec 2022 12:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSRxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2022 12:53:04 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB321261A
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 09:53:00 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id s16so5106414iln.4
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vo6wOkLQUlJhsHSXKG80f4a+S6WzYtJqtuDoUMM5h+8=;
        b=zueGYCVd9ApIrLIldaLXnXpMR1Buttw6LqUDH5EA1FerFQ8BlryWoIBXgVdF4pUlgo
         vR8OlhTmR17zW/VTPC3L2NfF5jyKFvfTmO2HPmZZttNZUdPjtwFGjSTr0DjmugOYfC3R
         IzOaVvw5lXswdqhpbDfWiqlKfMsBbkevC8apZzlipjSoOcwXo8ubdSj7qYGdp6a/8eTM
         XEzkmi75hlqkVARFx6Qb8NGmP1Y2FKVlSQ4+RG7J9VJ3tg2ZWF5gpcPnFdeiRobK7nQg
         fxOAMO9vyQ50QSPc5ntN2ADXVWDlUOMEZD31hn6XOLzHeUGw0dc3OhAdAHBIXg5WCE42
         mQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo6wOkLQUlJhsHSXKG80f4a+S6WzYtJqtuDoUMM5h+8=;
        b=5+CFiJuHU+raGaaFU2n/sZpSVjKCulqFcV7jn6OKrne+OGaYx7G5KaKltMdsfV8t3M
         wdmbUOL2Cws0RpMGzGMgQ5t0s5tvsjkNd9j/rTlOb9Y/KI5av11oFw6m7o7NFqM8vtaB
         ms22tcuXC++P1ApyJdZt3wrGPUNu1J+9h8mBaAPCm0va9IjR1w1YpLXdHAhoJb9ymvZ2
         LNjoA9nBfZ2YwLO5rFOwwNQAv3btSsUImmO3ug08iRQTy5aDZu26ggiVdTobovY6yEMu
         wgkuNAFB4XD56pOf5nsp2SRHOD8hCctpbzekd+5+ds3tNVCSu2HjzxWR5UiW+xVpAmtY
         +5uQ==
X-Gm-Message-State: ANoB5pkrjciEty4eVIYWMxKLBsDYkr+VR0NhzdLJ1Lg2uj5rPftFqBBk
        lzwOa+ZE4UGCzSpviKUtFbu7yA==
X-Google-Smtp-Source: AA0mqf5nRK7boaaLyFT8xBriLIBaeMve0Dxq43TFqM8HGfPF6MRrdts0rWiMTesne3FaUBtIxH1GqA==
X-Received: by 2002:a92:c88f:0:b0:2ff:97a8:5aab with SMTP id w15-20020a92c88f000000b002ff97a85aabmr4829154ilo.3.1671472379564;
        Mon, 19 Dec 2022 09:52:59 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b14-20020a92670e000000b00300b9b7d594sm3375055ilc.20.2022.12.19.09.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 09:52:59 -0800 (PST)
Message-ID: <b480e35d-5171-425b-31c6-3a7fe5b8a666@kernel.dk>
Date:   Mon, 19 Dec 2022 10:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [bug report]BUG: KFENCE: use-after-free read in
 bfq_exit_icq_bfqq+0x132/0x270
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs-MzFV6WTfveRXTARsik9wTGgado2U4vnT8oH6vmfFjzQ@mail.gmail.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHj4cs-MzFV6WTfveRXTARsik9wTGgado2U4vnT8oH6vmfFjzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/19/22 12:16 AM, Yi Zhang wrote:
> Hello
> Below issue was triggered during blktests nvme-tcp with for-next
> (6.1.0, block, 2280cbf6), pls help check it
> 
> [  782.395936] run blktests nvme/013 at 2022-12-18 07:32:09
> [  782.425739] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  782.435780] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  782.446357] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0042-3910-8039-c6c04f544833.
> [  782.460744] nvme nvme0: creating 32 I/O queues.
> [  782.466760] nvme nvme0: mapped 32/0/0 default/read/poll queues.
> [  782.479615] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420
> [  783.612793] XFS (nvme0n1): Mounting V5 Filesystem
> [  783.650705] XFS (nvme0n1): Ending clean mount
> [  799.653271] ==================================================================
> [  799.660496] BUG: KFENCE: use-after-free read in bfq_exit_icq_bfqq+0x132/0x270
> [  799.669117] Use-after-free read at 0x000000008c692c21 (in kfence-#11):
> [  799.675647]  bfq_exit_icq_bfqq+0x132/0x270
> [  799.679753]  bfq_exit_icq+0x5b/0x80
> [  799.683255]  exit_io_context+0x81/0xb0
> [  799.687015]  do_exit+0x74b/0xaf0
> [  799.690256]  kthread_exit+0x25/0x30
> [  799.693758]  kthread+0xc8/0x110
> [  799.696904]  ret_from_fork+0x1f/0x30
> [  799.701991] kfence-#11: 0x00000000f1839eaa-0x0000000011c747a1,
> size=568, cache=bfq_queue
> [  799.711549] allocated by task 19533 on cpu 9 at 499.180335s:
> [  799.717218]  bfq_get_queue+0xe0/0x530
> [  799.720884]  bfq_get_bfqq_handle_split+0x75/0x120
> [  799.725592]  bfq_insert_requests+0x1d15/0x2710
> [  799.730045]  blk_mq_sched_insert_requests+0x5c/0x170
> [  799.735021]  blk_mq_flush_plug_list+0x115/0x2e0
> [  799.739551]  __blk_flush_plug+0xf2/0x130
> [  799.743479]  blk_finish_plug+0x25/0x40
> [  799.747231]  __iomap_dio_rw+0x520/0x7b0
> [  799.751070]  btrfs_dio_write+0x42/0x50
> [  799.754832]  btrfs_do_write_iter+0x2f4/0x5d0
> [  799.759112]  nvmet_file_submit_bvec+0xa6/0xe0 [nvmet]
> [  799.764193]  nvmet_file_execute_io+0x1a4/0x250 [nvmet]
> [  799.769349]  process_one_work+0x1c4/0x380
> [  799.773361]  worker_thread+0x4d/0x380
> [  799.777028]  kthread+0xe6/0x110
> [  799.780174]  ret_from_fork+0x1f/0x30
> [  799.785252] freed by task 19533 on cpu 9 at 799.653250s:
> [  799.790584]  bfq_put_queue+0x183/0x2c0
> [  799.794344]  bfq_exit_icq_bfqq+0x129/0x270
> [  799.798442]  bfq_exit_icq+0x5b/0x80
> [  799.801934]  exit_io_context+0x81/0xb0
> [  799.805687]  do_exit+0x74b/0xaf0
> [  799.808920]  kthread_exit+0x25/0x30
> [  799.812413]  kthread+0xc8/0x110
> [  799.815561]  ret_from_fork+0x1f/0x30
> [  799.820648] CPU: 9 PID: 19533 Comm: kworker/dying Not tainted 6.1.0 #1
> [  799.827181] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
> 2.15.1 06/15/2022
> [  799.834746] ==================================================================
> [  823.081364] XFS (nvme0n1): Unmounting Filesystem
> [  823.159994] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"

Please CC maintainers on stuff like this (added).

-- 
Jens Axboe


