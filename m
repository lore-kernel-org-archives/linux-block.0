Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B218C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 01:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E054B20651
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 01:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfAQBGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:06:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46155 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfAQBGu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 20:06:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so3911094pfe.13;
        Wed, 16 Jan 2019 17:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gW2Mpc6y2UOvu+xsaEfsAbRu4WZ2YWJ0t/cgK+C16Ig=;
        b=DsF7WSo7kwHcuX5S/40UoNQv10ibUUMbkU9IMUm960Aopck1OwTgxMl+gmlccWJs5e
         WiI2aU/ICiY8ASm/kMEVY+6+LdYS/gBOVzlPTMLaNEVg6bqa/lv6sQAbGteoKuC+nC2R
         ZmltqNlwQBq/3d97qOgHsUknbnR+XTi2V21YL1ypfg4CKVlhTpJfyZxMW87ASqZBnJ0t
         andEvo7828x9ccjDx7zTUKPYGxSWxrwXSd0pLJmcIpqGzobA8nIoyFhJdj/VCanDLsbY
         VqYEvUIoc4zbnKvnn4yQsEfM5mHe+ygSwKfwLWbdukXwxeaNN134Aysrj7OPz56ZdZJc
         JNWg==
X-Gm-Message-State: AJcUukeDXX5GLM+WSvXc3qT/IOUNCrBDUFtKPtX3JtnfXmXm0KjLFIlL
        eMlDWE+k5fC3Zp1XKmwJkj4=
X-Google-Smtp-Source: ALg8bN6MbcTlTvQ9Hr082lVJj+6DUpXHNNgxyhsK5aaYmRfiJmFStJSIvywI6XEQiERufeH/43Iaxg==
X-Received: by 2002:a63:fb4c:: with SMTP id w12mr11607827pgj.321.1547687208711;
        Wed, 16 Jan 2019 17:06:48 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 15sm35221pfr.55.2019.01.16.17.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 17:06:47 -0800 (PST)
Message-ID: <1547687206.83374.127.camel@acm.org>
Subject: Re: [PATCH fix] scsi_lib: make sure scsi_request.sense valid
From:   Bart Van Assche <bvanassche@acm.org>
To:     dgilbert@interlog.com, hch@infradead.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
Date:   Wed, 16 Jan 2019 17:06:46 -0800
In-Reply-To: <023a9df4-8295-bf2e-ed3e-e191994b5fb1@interlog.com>
References: <20190116155700.28967-1-dgilbert@interlog.com>
         <1547682979.83374.126.camel@acm.org>
         <023a9df4-8295-bf2e-ed3e-e191994b5fb1@interlog.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-01-16 at 19:54 -0500, Douglas Gilbert wrote:
+AD4 On 2019-01-16 6:56 p.m., Bart Van Assche wrote:
+AD4 +AD4 On Wed, 2019-01-16 at 10:57 -0500, Douglas Gilbert wrote:
+AD4 +AD4 +AD4 The block layer assumes scsi+AF8-request:sense is always a valid
+AD4 +AD4 +AD4 pointer. This is set up once in scsi+AF8-mq+AF8-init+AF8-request() and the
+AD4 +AD4 +AD4 containing scsi+AF8-cmnd object is used often, being re-initialized
+AD4 +AD4 +AD4 by scsi+AF8-init+AF8-command(). That works unless some code re-purposes
+AD4 +AD4 +AD4 part of the scsi+AF8-cmnd object for something else. And that is
+AD4 +AD4 +AD4 what bidi handling does in scsi+AF8-mq+AF8-prep+AF8-fn(). The result is an
+AD4 +AD4 +AD4 oops at some later time when the partly overwritten object is
+AD4 +AD4 +AD4 re-used. The overwrite is from d285203cf647d but 'git blame'
+AD4 +AD4 +AD4 does not show removed code, so that commit may not be the
+AD4 +AD4 +AD4 culprit.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Signed-off-by: Douglas Gilbert +ADw-dgilbert+AEA-interlog.com+AD4
+AD4 +AD4 +AD4 ---
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 This was found while injecting errors (thus generating sense data)
+AD4 +AD4 +AD4 into a sequence of bidi commands. At some later time the block
+AD4 +AD4 +AD4 layer blew up with a scsi+AF8-request::sense NULL dereference in
+AD4 +AD4 +AD4 sg+AF8-rq+AF8-end+AF8-io(). Without testing I'm confident the bsg driver,
+AD4 +AD4 +AD4 the osd ULD and exofs are exposed to this bug.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4   drivers/scsi/scsi+AF8-lib.c +AHw 1 +-
+AD4 +AD4 +AD4   1 file changed, 1 insertion(+-)
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 diff --git a/drivers/scsi/scsi+AF8-lib.c b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AD4 +AD4 index b13cc9288ba0..71259bd4040a 100644
+AD4 +AD4 +AD4 --- a/drivers/scsi/scsi+AF8-lib.c
+AD4 +AD4 +AD4 +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AD4 +AD4 +AEAAQA -1175,6 +-1175,7 +AEAAQA void scsi+AF8-init+AF8-command(struct scsi+AF8-device +ACo-dev, struct scsi+AF8-cmnd +ACo-cmd)
+AD4 +AD4 +AD4   
+AD4 +AD4 +AD4   	cmd-+AD4-device +AD0 dev+ADs
+AD4 +AD4 +AD4   	cmd-+AD4-sense+AF8-buffer +AD0 buf+ADs
+AD4 +AD4 +AD4 +-	cmd-+AD4-req.sense +AD0 buf+ADs
+AD4 +AD4 +AD4   	cmd-+AD4-prot+AF8-sdb +AD0 prot+ADs
+AD4 +AD4 +AD4   	cmd-+AD4-flags +AD0 flags+ADs
+AD4 +AD4 +AD4   	INIT+AF8-DELAYED+AF8-WORK(+ACY-cmd-+AD4-abort+AF8-work, scmd+AF8-eh+AF8-abort+AF8-handler)+ADs
+AD4 +AD4 
+AD4 +AD4 Hi Doug,
+AD4 +AD4 
+AD4 +AD4 The description of this patch does not look correct to me. scsi+AF8-init+AF8-command()
+AD4 +AD4 does not overwrite the sense pointer. From the body of that function:
+AD4 +AD4 
+AD4 +AD4 	/+ACo zero out the cmd, except for the embedded scsi+AF8-request +ACo-/
+AD4 +AD4 	memset((char +ACo)cmd +- sizeof(cmd-+AD4-req), 0,
+AD4 +AD4 		sizeof(+ACo-cmd) - sizeof(cmd-+AD4-req) +- dev-+AD4-host-+AD4-hostt-+AD4-cmd+AF8-size)+ADs
+AD4 +AD4 
+AD4 +AD4 It is not clear to me which code overwrites the sense pointer. I think that
+AD4 +AD4 needs to be figured out before discussion of this patch can continue.
+AD4 
+AD4 Bart,
+AD4 Please re-read the explanation. The two sentences in the middle should tell
+AD4 you that you are looking at the wrong memset().
+AD4 
+AD4 And I'm waiting for the person who wrote the questionable code to comment.
+AD4 
+AD4 
+AD4 If you don't believe me, try sending a device reset to a scsi+AF8-debug device.
+AD4 Then use sg+AF8-raw +ACoAKgAq to send a XDWRITREAD(10) bidi command to the same scsi+AF8-debug
+AD4 device, you should get a Unit Attention concerning that device reset. If
+AD4 you do, keep sending that bidi command. Make sure you have no important
+AD4 files open because that machine will lock solid. Basically what happens
+AD4 when a rq+AF8-end+AF8-io() callback de-references a NULL pointer. It looks like
+AD4 it has been there since 2014 and took me 2 days to find. Sorry that I can't
+AD4 explain it in one simple sentence.

Hi Doug,

Is this perhaps the memset you are referring to?

		memset(bidi+AF8-sdb, 0, sizeof(struct scsi+AF8-data+AF8-buffer))+ADs

Bart.
