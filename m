Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE45FA3742
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 13:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJaNZD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiJaNZC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 09:25:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062DF658D
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 06:25:02 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 20so10699353pgc.5
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWMYmmmibwx2ReqBvBmNSoB8xLK3NIj0RwP04JMJrKs=;
        b=hlWtEEl6iiRSHfaS8OvLrFpy14iFbnLP+GsvSlcFeZKEuJA50HGmW1tTG5eLx5keTc
         N6PjXXS57sDwn99wfG6yb6iDuDnhLc5RBtYGrB/pokimiEYmTPpi0vOzPIsEin9MhoXZ
         DwfngRc16hqhXY1d/TdClaN0cjKpxSqTrhJ+vIi/53H89WW8BmbWVn3R+Vz+6DwxkN2e
         8zkdyHpbUTgh9KFUM0plNzJTGlg2+yChD2AlZ7MLNitu4UxWxt34XiET0+d78ZAkOtSz
         TXpw/5C4+PkTnlOTPCjg2sis0iHuaYc9zLTTIA48kK5WgeoD5CmqcXhknHS6L4QgXBNm
         zeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWMYmmmibwx2ReqBvBmNSoB8xLK3NIj0RwP04JMJrKs=;
        b=0dCKNMXR2X0AaJjCeru7dgRriBHLWocMXPP1nwUsh/C6RglcdEttFwJF4VP5TLqkSa
         xZ89cGylfc9zwC0+6dIteZnapxYULlxzfli3bf8OQ80LFZpDnd3OeTlE2bERidRYPvgA
         rRI0EHtDHBz6ifVhQh7Gq6nUcny4CeOQo7ETmsXegoqdlCVcKIrbYhqt6hK90GDVQ/0a
         PC6VoA/skjuWtgUGC78KVIemBSL87dxnck56gykzQlJky5Y6twYi1biGXjMt2gU6akAR
         Ci5EqrQUIR7dNf5fIyHdm4FTnp0PoHQpZLqzkDn/zIQD58cBQ0Kd2mCn6WrN7BR75Szt
         diQg==
X-Gm-Message-State: ACrzQf3iCHC6A1SEc6CqbSchgYYgU4O1R9sjedGfF9YclALVTMnDJ3CN
        jvlGoPpaHzlrdGfRG8aRZe6CVA==
X-Google-Smtp-Source: AMsMyM456NR3W00gWxHmZFr8p6oriRZjLZ710N39waLB35rFt/oiH19XaceqS3OEOm3/efWET8IGuQ==
X-Received: by 2002:a05:6a00:24cb:b0:56c:7815:bc7d with SMTP id d11-20020a056a0024cb00b0056c7815bc7dmr14543180pfv.44.1667222701423;
        Mon, 31 Oct 2022 06:25:01 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k28-20020aa7999c000000b0056bfebfa6e4sm4523279pfh.190.2022.10.31.06.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 06:25:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        David Jeffery <djeffery@redhat.com>
In-Reply-To: <20221026051957.358818-1-ming.lei@redhat.com>
References: <20221026051957.358818-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3 1/1] blk-mq: avoid double ->queue_rq() because of early timeout
Message-Id: <166722270044.66567.13274204671032495059.b4-ty@kernel.dk>
Date:   Mon, 31 Oct 2022 07:25:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 26 Oct 2022 13:19:57 +0800, Ming Lei wrote:
> From: David Jeffery <djeffery@redhat.com>
> 
> David Jeffery found one double ->queue_rq() issue, so far it can
> be triggered in VM use case because of long vmexit latency or preempt
> latency of vCPU pthread or long page fault in vCPU pthread, then block
> IO req could be timed out before queuing the request to hardware but after
> calling blk_mq_start_request() during ->queue_rq(), then timeout handler
> may handle it by requeue, then double ->queue_rq() is caused, and kernel
> panic.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: avoid double ->queue_rq() because of early timeout
      commit: 82c229476b8f6afd7e09bc4dc77d89dc19ff7688

Best regards,
-- 
Jens Axboe


