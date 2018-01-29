Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751650AbeA2VIl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jan 2018 16:08:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 223BE4F1B0
        for <linux-block@vger.kernel.org>; Mon, 29 Jan 2018 21:08:41 +0000 (UTC)
Date: Mon, 29 Jan 2018 16:08:37 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [LSF/MM TOPIC] block, dm: restack queue_limits
Message-ID: <20180129210836.GA5744@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We currently don't restack the queue_limits if the lowest, or
intermediate, layer of an IO stack changes.

This is particularly unfortunate in the case of FLUSH/FUA which may
change if/when a HW controller's BBU fails; whereby requiring the device
advertise that it has a volatile write cache (WCE=1).

But in the context of DM, really it'd be best if the entire stack of
devices had their limits restacked if any underlying layer's limits
change.

In the past, Martin and I discussed that we should "just do it" but
never did.  Not sure we need a lengthy discussion but figured I'd put it
out there.

Maybe I'll find time, between now and April, to try implementing it.

Thanks,
Mike
