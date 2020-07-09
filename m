Return-Path: <SRS0=YKm5=AU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38C9C433E1
	for <linux-block@archiver.kernel.org>; Thu,  9 Jul 2020 14:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD7520767
	for <linux-block@archiver.kernel.org>; Thu,  9 Jul 2020 14:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGIOxj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:53:39 -0400
Received: from mail.cybernetics.com ([173.71.130.66]:59318 "EHLO
        mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgGIOxj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jul 2020 10:53:39 -0400
X-ASG-Debug-ID: 1594305312-0fb3b01c5827c570001-Cu09wu
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id rPPfTzpDFp0QNXka; Thu, 09 Jul 2020 10:35:13 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
Received: from [10.157.2.224] (account tonyb HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 5.1.14)
  with ESMTPSA id 10089887; Thu, 09 Jul 2020 10:35:12 -0400
To:     stable <stable@vger.kernel.org>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Chris Mason <clm@fb.com>, Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jens Axboe <axboe@kernel.dk>
From:   Tony Battersby <tonyb@cybernetics.com>
Subject: Re: [PATCH] block: fix splitting segments on boundary masks
Message-ID: <94114379-78f6-6465-49de-99aa5b3f4d0d@cybernetics.com>
X-ASG-Orig-Subj: Re: [PATCH] block: fix splitting segments on boundary masks
Date:   Thu, 9 Jul 2020 10:35:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1594305313
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1110
X-Barracuda-BRTS-Status: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Although I was not originally involved in the development of these
patches, I recently came across them while looking over the source:

upstream commit 429120f3df2d ("block: fix splitting segments on boundary masks")
    Cc: stable@vger.kernel.org # v5.1+
    Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")

upstream commit 4a2f704eb2d8 ("block: fix get_max_segment_size() overflow on 32bit arch")
    Fixes: 429120f3df2d ("block: fix splitting segments on boundary masks")

https://www.spinics.net/lists/linux-block/msg48605.html
https://www.spinics.net/lists/linux-block/msg48959.html


The first patch mentions fixing problems with filesystem corruption, so
it seems important, but it has never been included in any -stable
kernel.  Is there a specific reason these patches have been excluded
from -stable, or is it just a mistake?

These patches would be relevant to kernel versions 5.1 - 5.4, with 5.4.y
being the only active stable kernel series in that range.  The patches
apply cleanly on top of 5.4.51.

Tony Battersby
Cybernetics

