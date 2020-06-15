Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67031C433DF
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 15:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3CE20679
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 15:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgFOP6r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:58:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47831 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727785AbgFOP6q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 11:58:46 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 05FFweKd027351
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 11:58:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D9BEA42026D; Mon, 15 Jun 2020 11:58:39 -0400 (EDT)
Date:   Mon, 15 Jun 2020 11:58:39 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-kernel@vger.kernel.org, inux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-block@vger.kernel.org,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
Subject: Maintainers / Kernel Summit 2020 submissions
Message-ID: <20200615155839.GF2863913@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far, we have received 5 techinical topic submissions for the Kernel
Summit; thanks to those who have submitted.  If you have some
additional ideas of technical topics you'd like to discuss at the
Kernel Summit, please submit them this week.  For details on how to
proposal a topic for the Kernel Summit, please see [1].

[1] https://lore.kernel.org/r/20200515163956.GA2158595@mit.edu

We have not, so far, gotten any submissions for the Maintainer's
Summit.  It's unclear whether this is because people have been
distracted with issues relating to the pandemic situation, or whether
things have been going swimingly from a process perspective, or if
people are just not as motivated to suggest topics if they can't
discuss them in a face-to-face setting as opposed to a virtual setting
---- or some combination of all of the above.

If you do have some ideas for things that you think are worth the
attention of a Maintainer's Summit this year, please kindly submit
them this week.  (Again, please see [1] for submission instructions.)
If we do not get sufficient submissions, we will need to consider
whether or not it makes sense to hold a Maintainer's Summit this year.

Thanks,

					- Ted
