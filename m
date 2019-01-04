Return-Path: <SRS0=wxXg=PM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFF8C43387
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 20:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF5C21872
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 20:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfADUti (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:49:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45932 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADUth (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jan 2019 15:49:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so18803556pfd.12
        for <linux-block@vger.kernel.org>; Fri, 04 Jan 2019 12:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4rIQVa1H38RC7FpdD+1oCJA+IqU948lfFpZwXiwtE0=;
        b=P4l9pdSU6cAhb/YKTYra077Allg666j/tavoq31OGvZPbvp8tUfwi/7obJn7VIMj3Y
         OXnqGbdJwlHgsfSdTH6Z8GEBAlDTMVWU8UzbhrSal7KGaRu5hUBETDND2crlhKs79nd7
         wChQnF0nutEOeZhO4bJon4JjmLhIy9TvlQujh0eFaVoxq8at0XVCztFc+moetJ+0POfD
         /otIj/5iI9wR/Hp/9IRu+L3UyknToxY3fAzA2X3wdqBHilEQZAbZa7DugfE3n/riwxmt
         XwSb1oBylM5h/e8bn/XYKE000PGGsLs/9DNclOvHEpLaUbyHuiTeM13aiXonyFX0/yFc
         X/2A==
X-Gm-Message-State: AJcUukctREpwM2IqkNjlFTVe0xV4pJx8mAPa3XLK4nTFpv8yR08liWCs
        fyuseuJ1HAgItRfdCvtjeISrpZcqbdc39g==
X-Google-Smtp-Source: ALg8bN60Vec0ZN5zlxfhsrb2k0/LvDjkO523E/5woONrsTxQQyGaNmgJglM9qotO3oCuFMpAq+6wmg==
X-Received: by 2002:a63:c051:: with SMTP id z17mr2835262pgi.20.1546634975691;
        Fri, 04 Jan 2019 12:49:35 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id g3sm127148968pfe.37.2019.01.04.12.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 12:49:34 -0800 (PST)
Message-ID: <1546634973.83374.4.camel@acm.org>
Subject: Re: [PATCH] null_blk: add zoned config support information
From:   Bart Van Assche <bvanassche@acm.org>
To:     John Pittman <jpittman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Date:   Fri, 04 Jan 2019 12:49:33 -0800
In-Reply-To: <CA+RJvhyfKrLwFkxAOxqAW=Mthu5HaF_JU6_rgKLjL07uD8TM+g@mail.gmail.com>
References: <20190104154243.3538-1-jpittman@redhat.com>
         <1546620417.163063.45.camel@acm.org>
         <CA+RJvhyfKrLwFkxAOxqAW=Mthu5HaF_JU6_rgKLjL07uD8TM+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-01-04 at 15:37 -0500, John Pittman wrote:
+AD4 Thanks Bart+ADs I made the changes and sent them in as a v2, I'm sure you
+AD4 already saw.  I have a quick, unrelated question if you have a moment.
+AD4 In testing the null+AF8-blk driver, I found that trim commands sent by fio
+AD4 were rejected due to lack of support.  Tracking down Shaohua's commit
+AD4 306eb6b4a (+ACI-nullb: support discard+ACI), he mentions that +ACI-discard makes
+AD4 sense for memory backed disk+ACI.  Just to see what would happen, I
+AD4 edited the source to make discard a configurable parameter at
+AD4 modprobe, and after the edit +ACY build, the trim commands submitted
+AD4 fine.  Does this sort of change make sense?  I mean the ability to do
+AD4 discard to null+AF8-blk without it being memory backed+ADs  solely for
+AD4 testing/benchmarking purposes.  I haven't found any good instructions
+AD4 on creating a memory backed or discard enabled null+AF8-blk device from
+AD4 the command line, so I assume a higher level driver would have to hook
+AD4 in and enable these features manually.  Thanks for your time and any
+AD4 information.

Hi John,

Jens as the block layer maintainer has the last word about this. Personally
I would welcome that functionality. Before discard functionality was removed
from the brd driver I used the brd driver to test the discard functionality
in storage target stacks. If discard functionality would be added to the
null+AF8-blk driver then that would make it possible to use that driver for
testing the discard functionality in e.g. LIO. See also commit f09a06a193d9
(+ACI-brd: remove discard support+ACI).

I'm not sure that we need a modprobe parameter to enable or disable trim
functionality in the null+AF8-blk driver. I'm fine with always enabling trim
functionality in that driver.

Bart.
