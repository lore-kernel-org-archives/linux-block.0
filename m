Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:39087 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756694AbdLPTQW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Dec 2017 14:16:22 -0500
Received: by mail-oi0-f51.google.com with SMTP id r63so8283288oia.6
        for <linux-block@vger.kernel.org>; Sat, 16 Dec 2017 11:16:22 -0800 (PST)
From: Lee Tibbert <lee.tibbert@gmail.com>
To: linux-block@vger.kernel.org
Cc: paolo.valente@linaro.org
Subject: [PATCH IMPROVEMENT] block, bfq: consider also past I/O in soft real-time detection
Date: Sat, 16 Dec 2017 14:16:16 -0500
Message-Id: <20171216191616.4388-1-lee.tibbert@gmail.com>
In-Reply-To: <20171215062312.1836-2-paolo.valente@linaro.org>
References: <20171215062312.1836-2-paolo.valente@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Tested-by: Lee Tibbert <lee.tibbert@gmail.com>
