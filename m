Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D295BC74A35
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD3D2064A
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfGJUSa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:18:30 -0400
Received: from ale.deltatee.com ([207.54.116.67]:57948 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJUSa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 16:18:30 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hlJ2q-0002Qn-6B; Wed, 10 Jul 2019 14:18:28 -0600
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     osandov@fb.com, Michael Moese <mmoese@suse.de>,
        linux-block@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d42ac748-f6fe-1014-f066-160cd087ce0d@deltatee.com>
Date:   Wed, 10 Jul 2019 14:18:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: tytso@mit.edu, linux-block@vger.kernel.org, mmoese@suse.de, osandov@fb.com, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: blktests: Nvme Target Generation Counter Issue
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey,

[I posted the following on the relevant github PR[1], though I'm
resending here to include the mailing lists and anyone who maybe doesn't
follow github]

The generation counter issue with NVMe target tests still seems to be an
issue even after a few months. I've found people complaining about it on
the list (@tytso) but I'm still seeing these failures in test
nvme/002,016 and 017 with no obvious resolution. The change in PR 34[1]
seems like the only sensible solution I've found so far (I've tested it
to ensure it works).

The generation counter is a static variable in the NVMe Target code that
gets incremented any time the discovery information changes. My best
guess is that the kernel started incrementing this for more reasons
since the tests were written and now the tests are broken.

IMO, masking these changes out as suggested in this PR is the best
solution. Then, if we want to test the generation counter, create
another test that ensures the counter changes after performing specific
actions.

If we do that, we can also remove the "modprobe -r" calls (which are
necessary to reset the counter) and be able to support running the tests
with the modules built-in (which would be very nice for people trying to
test the kernel in VMs).

One way or another, we need a solution that's less fragile than the
current method.

Thanks,

Logan



[1] https://github.com/osandov/blktests/pull/34
