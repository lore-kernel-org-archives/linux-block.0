Return-Path: <linux-block-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:59442 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbeGaXMh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jul 2018 19:12:37 -0400
Date: Tue, 31 Jul 2018 14:30:15 -0700 (PDT)
Message-Id: <20180731.143015.1326547191404152411.davem@davemloft.net>
To: keescook@chromium.org
Cc: axboe@kernel.dk, hch@infradead.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, tj@kernel.org, bp@alien8.de,
        manoj@linux.vnet.ibm.com, mrochs@linux.vnet.ibm.com,
        ukrishn@linux.vnet.ibm.com, nab@linux-iscsi.org,
        tglx@linutronix.de, pombredanne@nexb.com, sboyd@codeaurora.org,
        cyrille.pitchen@free-electrons.com, jgross@suse.com,
        viresh.kumar@linaro.org, u.kleine-koenig@pengutronix.de,
        sdharia@codeaurora.org, rdunlap@infradead.org,
        vinod.koul@intel.com, david.kershner@unisys.com,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] ide-cd: Remove redundant sense buffer
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180731195155.46664-7-keescook@chromium.org>
References: <20180731195155.46664-1-keescook@chromium.org>
        <20180731195155.46664-7-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Tue, 31 Jul 2018 12:51:51 -0700

> This is already able to process the sense buffer, so remove the redundant
> parsing during the failure path. This also fixes any possible stale values
> since the prior code did not check the sense length.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: David S. Miller <davem@davemloft.net>
