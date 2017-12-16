Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:39590 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756694AbdLPTBU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Dec 2017 14:01:20 -0500
Received: by mail-oi0-f43.google.com with SMTP id r63so8270171oia.6
        for <linux-block@vger.kernel.org>; Sat, 16 Dec 2017 11:01:20 -0800 (PST)
From: Lee Tibbert <lee.tibbert@gmail.com>
To: linux-block@vger.kernel.org
Cc: paolo.valente@linaro.org
Subject: [PATCH IMPROVEMENT] block, bfq: consider also past I/O in soft real-time detection
Date: Sat, 16 Dec 2017 14:01:09 -0500
Message-Id: <20171216190109.3875-1-lee.tibbert@gmail.com>
In-Reply-To: <20171215062312.1836-2-paolo.valente@linaro.org>
References: <20171215062312.1836-2-paolo.valente@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

