Return-Path: <SRS0=4SCO=RN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E9CC43381
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 18:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5882084F
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 18:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqamRj0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfCJSMI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:12:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45136 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfCJSMI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Mar 2019 14:12:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id o7so2622021wrp.12
        for <linux-block@vger.kernel.org>; Sun, 10 Mar 2019 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H88sdlUkeF0SgIUzFqNM+Be+vdLABi7IVAQP8mI4xOk=;
        b=qqamRj0eRTo8Oc0l1xnaMl2P824rS6v0Hxmvnnq6PpkF3WhMDYx2AEQIRx31irQOIw
         7by5LfsWeYtLcGG39QCBg+JeoAVfe8CBZxj/j435FzKzeh2ctosXpw7LAehbOj0KBJeQ
         Uia+Cwv8FIYnqYpyzL31R+zbKWKR3+uVSkGD3gm+LCCSpehZSvxQ/aKD+1Jt01hJom8c
         GmPxS3wPr22XuTNaPiIG494FG7DxGiWOHWWjZVZFi8FgiTbh3V32fm3BNiSAeHG2EOLC
         /Wg8mG7atOBoleVOQA48sJ97tL3juD2voAVI2T7cEj+jReItbWee7xBHRg1RLQwUye3b
         DFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H88sdlUkeF0SgIUzFqNM+Be+vdLABi7IVAQP8mI4xOk=;
        b=g/MtEzyzCvxGRC0wP8Hlrpc1ZCr54ptihg5WWBcIVzRhcnDjs1pMo0VUecCHEGIHMg
         nL1g9KoOYHMBh9EZ5XIfrAOfkmU0ng8+vQ65CbD6gEe2Ks5O+IPF8U80VVJgYWr1/wXI
         hmtDMlAelttpyQbH2zyjy/QTEgyFwbBWgcFofMNL0RW0+pA9cTi0eTZSEAkOWKyWF37X
         RIoHhm1pid55kk0dDWZRBsqmDeSw5LX5IKuyx5SpHnCxe7TXSgbbYXZsirW/Ev/KvYmV
         AbxyHHhGQyqsuWI8v/7/+OmuoNBWy/SO/AdYabt/eCWsRMqiguqgKpevAjlhmSAksSV4
         cQYA==
X-Gm-Message-State: APjAAAWGDeApc3JvoE1WiLGbP2j0BK7vf/+vWsLu0e9m6m4ui5Q6h9jl
        mSNfGdzYV7uZsjGAAF3JU6cdWw==
X-Google-Smtp-Source: APXvYqzhBfC2rkbKKiNiKnqIN+mZn6mmoDOItjF2YX7MDn45J8lYSo/fAx0OznwzMVznbYFwXMhA9A==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr17701425wrt.12.1552241525872;
        Sun, 10 Mar 2019 11:12:05 -0700 (PDT)
Received: from localhost.localdomain (146-241-67-113.dyn.eolo.it. [146.241.67.113])
        by smtp.gmail.com with ESMTPSA id d206sm24906368wmc.11.2019.03.10.11.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:12:04 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 0/9] block, bfq: fix bugs, reduce exec time and boost performance
Date:   Sun, 10 Mar 2019 19:11:28 +0100
Message-Id: <20190310181137.2604-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
this is the v2 of the series
https://lkml.org/lkml/2019/3/7/461
that fixes some bug affecting performance, reduces execution time a
little bit, and boosts throughput and responsiveness.

The difference w.r.t. v1 is that Francesco has fixed compilation
issues of patch "block, bfq: print SHARED instead of pid for shared
queues in logs".

I took the opportunity of this v2 to also add BFQ's execution time to
the documentation.

Let me remind again that these patches are meant to be applied on top
of the last series I submitted:
https://lkml.org/lkml/2019/1/29/368

Thanks,
Paolo

Francesco Pollicino (2):
  block, bfq: print SHARED instead of pid for shared queues in logs
  block, bfq: save & resume weight on a queue merge/split

Paolo Valente (7):
  block, bfq: increase idling for weight-raised queues
  block, bfq: do not idle for lowest-weight queues
  block, bfq: tune service injection basing on request service times
  block, bfq: do not merge queues on flash storage with queueing
  block, bfq: do not tag totally seeky queues as soft rt
  block, bfq: always protect newly-created queues from existing active
    queues
  doc, block, bfq: add information on bfq execution time

 Documentation/block/bfq-iosched.txt |  29 +-
 block/bfq-cgroup.c                  |   3 +-
 block/bfq-iosched.c                 | 786 +++++++++++++++++++++++-----
 block/bfq-iosched.h                 |  92 ++--
 block/bfq-wf2q.c                    |   2 +-
 5 files changed, 729 insertions(+), 183 deletions(-)

--
2.20.1
