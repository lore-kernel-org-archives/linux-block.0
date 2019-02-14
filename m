Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1918C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B55222D4
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391880AbfBNTdu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:33:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40159 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfBNTdu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 14:33:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so3588906pfo.7;
        Thu, 14 Feb 2019 11:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2so8kiOFENLyPAkFgv1ffYpBNdVb7L0+z9Dwof+vfOo=;
        b=O8xnYIRrQ3tH6qY+rBXYOwOlvd3/pZ/nsvSnU4BuzvV80r6dtiO9bmGZ7+USFPfOVZ
         osWKc9c5eYUx5jis+WGdVrgw1FcC9wpjm+G1QZqzOYMFYDWMknQLzlqS8Zjt8grwzWku
         9Sq2KBd9TI4tAOz/pUqDbv98DKf8AnFzspm3SN8MdRGqvVD1pN9Wgs/p5VvFd/PxlSvW
         1X24j6LqbaJBJHkvOrSyCD93glge/RZElPvvbzE4Kfp5zcPS6470uylad6Sxu9H3vnlF
         lyN++iV2ZlCiJaNyUaZqdwTAArftzK+5c0PFq11iVPH7eRG49KgCOax1R0xzi6cbE24K
         0JuQ==
X-Gm-Message-State: AHQUAuYpgVBVooWMe7irgPangPXEf9bsdJMJKlgsAZnYE+fIUaeAFHOw
        5E0PS++FMKY5e9yzLBhPQhs=
X-Google-Smtp-Source: AHgI3IaIbeUWh55fIGeN4DUxMv+KYMjLKJeaaZNr+m/dZ27nIwJ78/AdOJh9ccBkwZqWLEyJYvrh4Q==
X-Received: by 2002:a63:a:: with SMTP id 10mr1462650pga.121.1550172829716;
        Thu, 14 Feb 2019 11:33:49 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id 64sm4371786pff.101.2019.02.14.11.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 11:33:48 -0800 (PST)
Message-ID: <1550172827.93548.5.camel@acm.org>
Subject: Re: KASAN warning in bt_for_each
From:   Bart Van Assche <bvanassche@acm.org>
To:     Evan Green <evgreen@google.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Date:   Thu, 14 Feb 2019 11:33:47 -0800
In-Reply-To: <CAE=gft4_WiL87FtZnVmZok+oXPjK=GUb5tDUPGQFijddrB0Pbg@mail.gmail.com>
References: <CAE=gft4_WiL87FtZnVmZok+oXPjK=GUb5tDUPGQFijddrB0Pbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-02-14 at 10:04 -0800, Evan Green wrote:
+AD4 Greetings, block experts+ACE
+AD4 
+AD4 I'm trying to track down a KASAN warning I'm seeing in our downstream
+AD4 4.19 kernel, and I could use a little help. The warning looks like
+AD4 this:
+AD4 
+AD4 +AFs  224.564894+AF0 BUG: KASAN: use-after-free in bt+AF8-for+AF8-each+-0x1ac/0x28c
+AD4 +AFs  224.571195+AF0 Read of size 8 at addr ffffffc17c621340 by task fio/3851
+AD4 +AFs  224.577745+AF0
+AD4 +AFs  224.579320+AF0 CPU: 2 PID: 3851 Comm: fio Tainted: G W 4.19.16 +ACM-398

Please have a look at this e-mail thread:
https://lore.kernel.org/linux-block/1545261885.185366.488.camel+AEA-acm.org/

Bart.
