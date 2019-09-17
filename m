Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B13C4CEC9
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 15:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA1F218AC
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568733193;
	bh=z4CPOtHs6ihvYRKspJKvZFgoWbkRkqOf+ArxEH2TfdQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xB0nfLkNyMEst0Oavgvy4g+58sh6F6knllj2+5Fr3Cwqb+YyBYfHAmzAL3FfR1MtL
	 4I1skZvcmCMvXgebFs8oA7HFwidEGkg5ExLn1tFLrIz45OsG3Yvly09fh323AFRhS/
	 JD3d+h5urEZbDgeYK5Amc0goKs5HpX16sTmQ+nf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfIQPNN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:13:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37035 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfIQPNM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 11:13:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so4399043qkd.4;
        Tue, 17 Sep 2019 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2BszFrJE5DhvvCqO6dnoH5rt4IlU+zqhXXHVu1J4dUQ=;
        b=BdxsZV3xdouTBb85ev20LScZzJk9sHxCTS804kLTi4P+4cxV14+mdM/5k/CTfY7KYy
         QlIbcCNUMrm97b8uLRopqvPVyRIZWzE4h3GKMdK+b6Nxzijp/EzTlas3mw8Jc7C0q03Q
         z0GMOTss3RH52FWcirpt0t+ETLAx/ycrt2r6PRYvRj8iyP8tB0BjGNEuMdQ5TNGKvxz/
         HTJ5cTOptNPgmHGUkpqBjYcghQgHxfCvtUfOYAruMsjfvSNevICznZAXEw8Kv/MQLGxt
         z8h7yk2O4Y3phH9s8yE0gpXzECURVyKfHMKJyN+dW/wo7vWayo9UMyNkA6H/5LUhqKYc
         OKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=2BszFrJE5DhvvCqO6dnoH5rt4IlU+zqhXXHVu1J4dUQ=;
        b=EJNh6spvPJXb6KZaFRQ+ZVhjZXiXgmAnJVpDmVS1L+4ygo/EHeK8zpO3IwrJtxsy/6
         tOweanzqv8zb4V+kQnIX7K9avzW39jTHEW7jBut5bZpRtOckHHquKPLBrcQoghFeAIY4
         zf7Imjgm4HX8u/Qsn8mNYTiyJ9kiAYJcSkSkPTdDmY+VTDpGaWrjlf0AbeT0HruAexaj
         GCeEn65m9ROxmx8RPdYLV8y5BsNvIk1/CzrQeNqkwXPF3nNr3lzHfKzgq+gb8wKqlKa9
         3T9BUQMZn8QLh84Lb5BXNMW608SQT2BByswNkYzd8cKYhLBTueaA91veLEnO94u+eS2y
         f55w==
X-Gm-Message-State: APjAAAW8XGnxOxMeQkJzJl36RnlFfpJ3MIXCARDCURBuJgmDVaY9j/zS
        eIemTDvNHJo3nlLTofjIa/Q=
X-Google-Smtp-Source: APXvYqzbnXW2dyx9T1bmuFxvPhQjaNDo4H3H8poIc8cpF3BPdAICYHUB7s5ADRNkkXNPrDoMGqJVfA==
X-Received: by 2002:a37:7bc7:: with SMTP id w190mr4467178qkc.215.1568733190659;
        Tue, 17 Sep 2019 08:13:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8d29])
        by smtp.gmail.com with ESMTPSA id r7sm1365774qkb.82.2019.09.17.08.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 08:13:10 -0700 (PDT)
Date:   Tue, 17 Sep 2019 08:13:08 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH 1/2] blkcg: Export blkcg_conf_prep/finish() for bfq
Message-ID: <20190917151308.GH3084169@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bfq module build is currently broken due to these two functions.  Fix
it by export them.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Paolo Valente <paolo.valente@linaro.org>
---
 block/blk-cgroup.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -900,6 +900,7 @@ fail:
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(blkg_conf_prep);
 
 /**
  * blkg_conf_finish - finish up per-blkg config update
@@ -915,6 +916,7 @@ void blkg_conf_finish(struct blkg_conf_c
 	rcu_read_unlock();
 	put_disk_and_module(ctx->disk);
 }
+EXPORT_SYMBOL_GPL(blkg_conf_finish);
 
 static int blkcg_print_stat(struct seq_file *sf, void *v)
 {
