Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2ABC433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Dec 2021 20:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhLTUuy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhLTUuy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 15:50:54 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397CDC061574
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 12:50:54 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id x6so14825001iol.13
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 12:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=c9XJhvmZT/MX0Dmn9tb6Hib0N0oOR8X9axj2urQ+ZSE=;
        b=QhIEVb1sdRi9DSwei1pPOGnv4H5m/kGldy1JqqHn/TX5YJFyloAxEF0Q/vQ+XgoHaF
         f/notsBLa7mUrVpdhZuNF8FVhfR4oLy6gP8rjlGPWJD+inb7UgvHgcTMWtGUH+cbI4PG
         gyi0p1tLClbr6amGO+vUZMSHJLv48/UP7Ip60msMiDs3E9Io0Eqgx8JjJAyDHK5XAbb4
         l85Vm04lswpBKT70EoYygMKyEvthclWkiBJ6szdQ2oTAvbcw6yLrGoirNiGp+8X4zmtE
         xgi3zQfI+MdxkKcooDKGbM8E24HHfqZG9IImZkDtnMIR4z7U5wG5ayD3jRGhiMDZDjuW
         cfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=c9XJhvmZT/MX0Dmn9tb6Hib0N0oOR8X9axj2urQ+ZSE=;
        b=lMGY+zi3SPsYY6JB17q2gti1gPOd+VtOsuMcJya4zcqYi+Pl+Bse3apNZWFDJT8W39
         o+Ghddw5bytH5+plzSPHD3axemshi+jqQMAOo/wU7lPBSiLL2+bBekAncZP8AkZBBb2j
         nDpe2hqSGflBrCeAf4rH5nRFgWmQvLryRvEKZXEU1ZflZpHnAOQgOZIGWJ2OATTGqLgQ
         Ns2JAwbML7HRiFML3o0+O2gmhw0/zWAzETbeZXLlCdjpj4FWTwO2XkBngvt2LqHLGtAr
         Y7fy0pi8jANRxwad/iV06nzMR5YeFZt1okx+zqKcNkxtYp+Eo59JJ2TOcfTQNKRDzicL
         1BLA==
X-Gm-Message-State: AOAM533V25ROagCiSrAZ93d8XDCODtD8Ftt17A0p9tfoFRxNpebelQvp
        5z3irb4l7jEk4YN7CxMvU9L9qQ==
X-Google-Smtp-Source: ABdhPJzG7HYpgxUCbycJzyxcFvYpTM27QXhTJAT+2v6Ij02m6D8f14QUwUR71k55FnP+H0wQFCoL7A==
X-Received: by 2002:a05:6602:1552:: with SMTP id h18mr9327079iow.183.1640033453635;
        Mon, 20 Dec 2021 12:50:53 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t9sm1349672ilu.50.2021.12.20.12.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 12:50:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Wander Lairson Costa <wander@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20211220192827.38297-1-wander@redhat.com>
References: <20211220192827.38297-1-wander@redhat.com>
Subject: Re: [PATCH v5 1/1] blktrace: switch trace spinlock to a raw spinlock
Message-Id: <164003345302.532019.10882095301451527257.b4-ty@kernel.dk>
Date:   Mon, 20 Dec 2021 13:50:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 20 Dec 2021 16:28:27 -0300, Wander Lairson Costa wrote:
> The running_trace_lock protects running_trace_list and is acquired
> within the tracepoint which implies disabled preemption. The spinlock_t
> typed lock can not be acquired with disabled preemption on PREEMPT_RT
> because it becomes a sleeping lock.
> The runtime of the tracepoint depends on the number of entries in
> running_trace_list and has no limit. The blk-tracer is considered debug
> code and higher latencies here are okay.
> 
> [...]

Applied, thanks!

[1/1] blktrace: switch trace spinlock to a raw spinlock
      commit: 361c81dbc58c8aa230e1f2d556045fa7bc3eb4a3

Best regards,
-- 
Jens Axboe


