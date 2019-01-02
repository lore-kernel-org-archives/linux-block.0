Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF6EC43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 03:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195F12089F
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 03:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfABDNK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Jan 2019 22:13:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46733 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfABDNJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Jan 2019 22:13:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so14007662pgp.13
        for <linux-block@vger.kernel.org>; Tue, 01 Jan 2019 19:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kryuA/mCmmbL1zlSuTxcMOhzEGYdc/RAi4QiwQXEerY=;
        b=SEp+cft4zLXcdxZ2rOCMKNXTKlin34uoIhAZVShvgv/3GJXFbi0+Nox6QUagIJFvXB
         RW0+cXHODbj9bJ1LpTZl5HST4BiXGKmg9nziCxh9EXfGyVPb0khljMujPF6wzzC5m2G3
         IRWN1P61JIsNjaL2nwxRXmnktn5ZZj/6Y9BCsU2ZtQUbMYNPmKOSiR29NMqF/mrnUpod
         YOd4JMQukFfHpVOpOleiFQXwe050Sr93FvW4GHwCsKPELwBfbT4vWVr/N5YzUqYP2qgv
         sMwWYPky9SmPLf73S0ICbkt9natrmdNeMTaCqXNdn1hKpSxBFRzp5OPGDcwQysJFRkwt
         3qAg==
X-Gm-Message-State: AA+aEWYQ5035lbl9zdYuOVf28OV7kcEjtlXmL3ZuvL/TPm8LWpUTU6c9
        9t2dBBNFEVFYu0IA1hjyExRJE+P/
X-Google-Smtp-Source: ALg8bN7FmPY96H71Zuc6ru9eQZ814P26wUqh4CrTxRMwucMK5UQvZltaLOqWOw5MGxyarNzpOJf8WA==
X-Received: by 2002:a62:b15:: with SMTP id t21mr44608009pfi.136.1546398788668;
        Tue, 01 Jan 2019 19:13:08 -0800 (PST)
Received: from asus.site (c-73-222-28-29.hsd1.ca.comcast.net. [73.222.28.29])
        by smtp.gmail.com with ESMTPSA id g15sm233867630pfj.131.2019.01.01.19.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 19:13:07 -0800 (PST)
Subject: Re: [PATCH 1/3] blktests: add cgroup2 infrastructure
To:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, osandov@fb.com
References: <20181204174733.7423-1-josef@toxicpanda.com>
 <20181204174733.7423-2-josef@toxicpanda.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1211bf78-c442-ea71-9e71-f6d86681ed56@acm.org>
Date:   Tue, 1 Jan 2019 19:13:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181204174733.7423-2-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/18 9:47 AM, Josef Bacik wrote:
> In order to test io.latency and other cgroup related things we need some
> supporting helpers to setup and tear down cgroup2.  This adds support
> for checking that we can even configure cgroup2 things, set them up if
> need be, and then add the cleanup stuff to the main cleanup function so
> everything is always in a clean state.

Is this the patch that went in as commit ae7daae7e35a ("blktests: add 
cgroup2 infrastructure")? I think that commit introduced a regression. 
With that patch applied the SRP tests fail as follows:

# ./check -q srp/001
srp/001 (Create and remove LUNs)
     runtime  4.067s  ...
common/cgroup: line 25: CGROUP2_DIR: unbound variable

Is this a known issue?

Bart.
