Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:42421 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936079AbdLSIZy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Dec 2017 03:25:54 -0500
Received: by mail-wr0-f169.google.com with SMTP id s66so17809961wrc.9
        for <linux-block@vger.kernel.org>; Tue, 19 Dec 2017 00:25:53 -0800 (PST)
Received: from smtp.gmail.com:465 (uk.sesame.canonical.com. [91.189.88.154])
        by smtp.gmail.com with ESMTPSA id e25sm12147486edc.64.2017.12.19.00.25.50
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Dec 2017 00:25:52 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <koalinux@gmail.com>
To: linux-block@vger.kernel.org
Subject: 
Date: Tue, 19 Dec 2017 10:26:11 +0200
Message-Id: <20171219082612.16584-1-koalinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch enables scsi pm on systems where mq is explicitly disabled.
