Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567D6C10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2762B20825
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfDOP4i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:56:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43563 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfDOP4i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 11:56:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so8775775pgu.10
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2019 08:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fi/6r48jSEz80r9PXbD+VjmhxGFECO8Y9+g4T/CEUtg=;
        b=FfycooSyh45/aPgg3Yq0RlTuXCRZ1laIhV+UtrlOmbK3s8p2Y5Gjw4r+EtdHeKclvl
         ytPbGSkNQXwEZpX13Zhb1Ynaxtz7UngKsoKZuXC67vEWiDt4OmQaWLzTJ6+DwlNLtHHT
         ryZde18W/KjQ4v+oQeFKnxSFqjVrHxijHgBOnoCTfKT76pG1KjWg9rr+6SkbIf5KgoIy
         YVWyKDK7XIHWEP5LZt5BaMVenwEfSNn5Rfdt+1wbNJnECVwDB5h+aYtzenRa5u/e9QvI
         JyNC1DfXQ8yhV7mUdOOtOgCQI+d7MYOMLget5rhu6Wzj1YgtVOA/9Fn5K0keTIklWcMD
         PtwA==
X-Gm-Message-State: APjAAAV0SrliwreLoRu+xyjYFF86gUlapYmRPb+OHftZs7oyelXYCHWG
        0Vm9Dlxx3sLIEpurh1drsRU=
X-Google-Smtp-Source: APXvYqzsvtkVn7xtdtL3wHJHJQdOHwwZBOKZwFClRdj+hyq2q/R0hiAAEKeLrRq5xY7OBQQknyhdJQ==
X-Received: by 2002:a65:6410:: with SMTP id a16mr57641540pgv.315.1555343797761;
        Mon, 15 Apr 2019 08:56:37 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s21sm33191009pfm.3.2019.04.15.08.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 08:56:36 -0700 (PDT)
Message-ID: <1555343795.161891.103.camel@acm.org>
Subject: Re: [PATCH v3] block: fix use-after-free on gendisk
From:   Bart Van Assche <bvanassche@acm.org>
To:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk, jack@suse.cz
Cc:     viro@zeniv.linux.org.uk, bart.vanassche@wdc.com,
        linux-block@vger.kernel.org
Date:   Mon, 15 Apr 2019 08:56:35 -0700
In-Reply-To: <20190402120634.51040-1-yuyufen@huawei.com>
References: <20190402120634.51040-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-02 at 20:06 +-0800, Yufen Yu wrote:
+AD4 diff --git a/block/genhd.c b/block/genhd.c
+AD4 index 961b2bc4634f..a4ef0068dbb2 100644
+AD4 --- a/block/genhd.c
+AD4 +-+-+- b/block/genhd.c
+AD4 +AEAAQA -529,6 +-529,18 +AEAAQA void blk+AF8-free+AF8-devt(dev+AF8-t devt)
+AD4         +AH0
+AD4  +AH0
+AD4  
+AD4 +-/+ACoAKg
+AD4 +- +ACo     We invalidate devt by assigning NULL pointer for devt in idr.
+AD4 +- +ACo-/
+AD4 +-void blk+AF8-invalidate+AF8-devt(dev+AF8-t devt)
+AD4 +-+AHs
+AD4 +-       if (MAJOR(devt) +AD0APQ BLOCK+AF8-EXT+AF8-MAJOR) +AHs
+AD4 +-               spin+AF8-lock+AF8-bh(+ACY-ext+AF8-devt+AF8-lock)+ADs
+AD4 +-               idr+AF8-replace(+ACY-ext+AF8-devt+AF8-idr, NULL, blk+AF8-mangle+AF8-minor(MINOR(devt)))+ADs
+AD4 +-               spin+AF8-unlock+AF8-bh(+ACY-ext+AF8-devt+AF8-lock)+ADs
+AD4 +-       +AH0
+AD4 +-+AH0

Did you perhaps copy the above code from blk+AF8-free+AF8-devt()? If so, please modify
blk+AF8-free+AF8-devt() such that it calls blk+AF8-invalidate+AF8-devt() instead of introducing a
copy of most of blk+AF8-free+AF8-devt().

Thanks,

Bart.
