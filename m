Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0ADC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E72521904
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbeLTVXM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:23:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40554 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbeLTVXK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 16:23:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so1453140pgp.7
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 13:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WmOrhWjUaqQrxHsSDnDx+/TpjpDdVHASKVQIJTlnbs=;
        b=Thmp5zRk/pHnZvU76WtO5xjQFCiK6A+clGGGqhr61HxT8ElkD9fPjS+GeEsJvtj07C
         TndrBNhFWG7qlFKfqePOeoO8sAfFFCcoMwkGAYczSDevgbfcJcYwnYemoPStwwBmBipN
         BK7mPZwpNrp+GxFRNcpvXCygf02r904ftOw0SlbI2/SxO8JUXJ5a9zOHnDVL8p9NbXnC
         dL7TvDzfyPeeUsEAiMJwVASuCzdnHTkyP9cSgrB4lGwGKEDbv5/VLN/pwQlERDks7uRC
         oehOu9h3Bjp/GhmkMH4ZVHC/Utt9qgr9/mRPI6Cduj6ItGkjnO3tCeN1bGf0cc+Pag4k
         YFdg==
X-Gm-Message-State: AA+aEWaPLoS3gJyFQOtzL1oFw2L7dIOfIy3F0JIXrIIQsBzhmYq7DUHc
        FmnBFvmkjKlviTF9i0uUbYu2d96jv90=
X-Google-Smtp-Source: AFSGD/Wrj1aG+v/M9NziQ4Wzqfrlaw0HpFutls/HBGWQzbFNwcdu9WmJCmhWRj48B9J2MkV9kIgRtA==
X-Received: by 2002:a62:28c9:: with SMTP id o192mr26249604pfo.57.1545340989245;
        Thu, 20 Dec 2018 13:23:09 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s9sm31122029pgl.88.2018.12.20.13.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:23:08 -0800 (PST)
Message-ID: <1545340987.185366.515.camel@acm.org>
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Thu, 20 Dec 2018 13:23:07 -0800
In-Reply-To: <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
References: <1545261885.185366.488.camel@acm.org>
         <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
         <1545265001.185366.496.camel@acm.org>
         <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
         <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
         <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
         <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
         <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
         <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
         <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
         <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
         <1545328865.185366.508.camel@acm.org>
         <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
         <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
         <1545339362.185366.511.camel@acm.org>
         <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-20 at 14:00 -0700, Jens Axboe wrote:
+AD4 On 12/20/18 1:56 PM, Bart Van Assche wrote:
+AD4 +AD4 +AEAAQA -96,6 +-97,9 +AEAAQA static void blk+AF8-mq+AF8-check+AF8-inflight(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4 +AD4  +AHs
+AD4 +AD4  	struct mq+AF8-inflight +ACo-mi +AD0 priv+ADs
+AD4 +AD4  
+AD4 +AD4 +-	if (rq-+AD4-q +ACEAPQ mi-+AD4-q)
+AD4 +AD4 +-		return+ADs
+AD4 
+AD4 Aren't you back to square one with this one, if the tags are shared? You
+AD4 can't dereference it before you know it matches.

My patch can only work if the new rq-+AD4-q +AD0 NULL assignment in +AF8AXw-blk+AF8-mq+AF8-free+AF8-request()
is executed before the request tag is freed and if freeing a tag does not happen
concurrently with any bt+AF8-iter() call. Would you accept that I add a seqlock to avoid
this scenario?

Thanks,

Bart.
