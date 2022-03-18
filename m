Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114BBC433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 02:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiCRCmT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Mar 2022 22:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiCRCmS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Mar 2022 22:42:18 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F59F108745
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 19:41:01 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id o13so4097001pgc.12
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 19:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=rD4sg48jtdha54PBbmThOR/GizumOsGvmi0qYjN75KI=;
        b=IEUcAmqKFhD1aUPPp+1Zu0L7be8UfGG9ZvVvHYrpa005mZfj+ReGp4WngVe71rKC0T
         +HCjQwmoc/K0HjwD+HfeCRXWiCQDYZxwxhuxo+8+VYykD7mpqnqUBEny/wUvynbrfeRH
         wXsxgbF2M5zB+YFJlSy3pdqo0yaoAXJACwhYgt8W2gsuhshcmNQI0vVKWS0HOrcrcbPL
         yPQjjO95tPFW9ge+LcBm3Fcd6ops96p8RA/29FXICUVuBPMxZMfvclM5eT7OnnJOSYNT
         AR5fGhHw+tjbH7buZMfwHDxPrJI6cz6oDTmv4YN5UNWoS+DQcRbm/GCnFnNSmZEruqqc
         xGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=rD4sg48jtdha54PBbmThOR/GizumOsGvmi0qYjN75KI=;
        b=LbjQab1oAV8rmbdo3vZVREf/VQC+9DEBqFKniILcbBbMRpqMZ2LSHMMIlDBQSDMSYf
         9ROgC0ZtdoQS73/6UDrOZCghPtFQTz20+Whsf9ztmVBEL4vEjrPFcyh89GlXXYsgYQgM
         8Ve/IKMI6gOjeZ4xLUVPBCTYHD7bCdP17LjVBkSYsLWQiMhXxvPjHNS8La0u4tAJrjsl
         0oSQrINkPHoq5DhB3PlxShlt0XaC1jP3PXXuxd+fEbUZ1y32DgvF2zI+TLMiiUOE9xMf
         DpPcRpp2ZEMhVvD2mW6lAG2m/FFPuRYaYLe7pm/ZmvW8USXPqeXpgcWtM1q/TaNXlN2r
         vfRQ==
X-Gm-Message-State: AOAM530+C1tsMWJ9b83BinX6Vcj/nu9ZZr0wwF3+IfD47N9RHYVvDsBA
        bXC9CELmqJculWrFu+RgdrkW7WNeB+sn6Qhy
X-Google-Smtp-Source: ABdhPJw4cd/P017n4qwqfg/ZddFzMBl8yxhZ/05IjlnQ0PZRAhBxhSLZJyOcVhIZJSIxetqd2aq/RQ==
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id bj2-20020a056a02018200b003745a57cbf9mr6074298pgb.616.1647571260621;
        Thu, 17 Mar 2022 19:41:00 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id pj13-20020a17090b4f4d00b001bf2ff56430sm11389086pjb.30.2022.03.17.19.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 19:41:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220318022641.133484-1-shinichiro.kawasaki@wdc.com>
References: <20220318022641.133484-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] block: limit request dispatch loop duration
Message-Id: <164757125962.111185.1072718598998010222.b4-ty@kernel.dk>
Date:   Thu, 17 Mar 2022 20:40:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 18 Mar 2022 11:26:41 +0900, Shin'ichiro Kawasaki wrote:
> When IO requests are made continuously and the target block device
> handles requests faster than request arrival, the request dispatch loop
> keeps on repeating to dispatch the arriving requests very long time,
> more than a minute. Since the loop runs as a workqueue worker task, the
> very long loop duration triggers workqueue watchdog timeout and BUG [1].
> 
> To avoid the very long loop duration, break the loop periodically. When
> opportunity to dispatch requests still exists, check need_resched(). If
> need_resched() returns true, the dispatch loop already consumed its time
> slice, then reschedule the dispatch work and break the loop. With heavy
> IO load, need_resched() does not return true for 20~30 seconds. To cover
> such case, check time spent in the dispatch loop with jiffies. If more
> than 1 second is spent, reschedule the dispatch work and break the loop.
> 
> [...]

Applied, thanks!

[1/1] block: limit request dispatch loop duration
      commit: 572299f03afd676dd4e20669cdaf5ed0fe1379d4

Best regards,
-- 
Jens Axboe


