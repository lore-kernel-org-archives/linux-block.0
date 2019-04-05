Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353A5C282CE
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 22:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017A42175B
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 22:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0AbjjKP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfDEWXa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:23:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33692 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEWXa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 18:23:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so3783739pgh.0
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2019 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TdKlS9NQNezZVzxbnJ4ba7jvFI/s2dr/POY6jCW3aRg=;
        b=0AbjjKP1PkHlHV7hRQ1EeKnpCg8oe0KCeSt+yx31EJYKzh2qMmljbHx4dO3UPo9KCe
         z1kyPm82cdaCIlF1PsRX2MY5Z3nwdGZN5QOdVCBkTAClIjlSNDC8c5DX2P0rnzjhE4rL
         K5irYAd9EKrTcym6ZMxkao7Q1/JPzmwUvA3ZY2Rn7P2OQBd4lLTbN+buaDctIAnvsh/b
         P83hHM6O92zHuhNd9XHb8GBR9npeGwXd/510/fk8YrP0aruXzFV4/7dBotnhpdmQIMSs
         VCvV7onoJOdnQ8D4s2C6IgmYVtFDR/Y+ake1bwsx/0v49aTY/88fzkZTKVASFlp6Qx1L
         qGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TdKlS9NQNezZVzxbnJ4ba7jvFI/s2dr/POY6jCW3aRg=;
        b=WRga4sm3h4+UB4kjBTZ/h8eY+cQ2WpdofnnYQAfy1aB4HzUYP2ys4XnIRi9nIfJ01l
         8ncxbXJOEpN15gDM+E98jb0d8rX+ufmLeyoUQXCipDj0+rmPu8cbo2sKRmVYoInzjc23
         OqaQBASVhNNKrOthY2f+SBSeaFZDKWHedMrtoCXZmSzl+pN5WoEghiNhCR+BoOz/lyEC
         F0LZQiskXPwXfUF7kJSsRZNbMm/rW3NtuKVxis0hPGVXO7wpYhTFinbUladza8BiDYsi
         cmpT+1JLD41Q3iL5HZN6K0oOC0u1v1EzvxZPDlBbJPh9VRKumAVmMmaKaTnkuDSq/x/b
         FVJg==
X-Gm-Message-State: APjAAAXSBUQtMalIUmO6B/UFGdTMpjdDKmROiDCyEEVOiK2XjBLFDC5Q
        ri45CS8YAbb3rtfZrB6SB+kYBg==
X-Google-Smtp-Source: APXvYqzrZbnIH+AehSmfrFk7P3XdRQZ4tfapZjK2CGEFKjAWU+3Y9jTXyVkkmdCGGCj9MRdG6cJQRw==
X-Received: by 2002:a63:6fc1:: with SMTP id k184mr14270625pgc.239.1554503009386;
        Fri, 05 Apr 2019 15:23:29 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id h19sm37616067pfd.130.2019.04.05.15.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 15:23:28 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
To:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190405215920.27085-1-keith.busch@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
Date:   Fri, 5 Apr 2019 16:23:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405215920.27085-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/19 3:59 PM, Keith Busch wrote:
> Managed interrupts can not migrate affinity when their CPUs are offline.
> If the CPU is allowed to shutdown before they're returned, commands
> dispatched to managed queues won't be able to complete through their
> irq handlers.
> 
> Introduce per-hctx reference counting so we can block the CPU dead
> notification for all allocated requests to complete if an hctx's last
> CPU is being taken offline.

What does this do to performance? We're doing a map per request...

-- 
Jens Axboe

