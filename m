Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:40737 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbdL1Awj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Dec 2017 19:52:39 -0500
Received: by mail-pf0-f169.google.com with SMTP id v26so20364760pfl.7
        for <linux-block@vger.kernel.org>; Wed, 27 Dec 2017 16:52:38 -0800 (PST)
Subject: Re: [for-416 PATCH 1/3] bcache: writeback: collapse contiguous IO
 better
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20171228004744.3522-1-mlyle@lyle.org>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <a2b093ac-7c9e-c791-808c-04dc1392d28e@lyle.org>
Date: Wed, 27 Dec 2017 16:52:36 -0800
MIME-Version: 1.0
In-Reply-To: <20171228004744.3522-1-mlyle@lyle.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey everyone,

These were previously sent and there was an extension discussion about
performance, finding that there was some slight regression on very large
extent workloads and significant performance improvement on smaller
extents.  This is a *huge* performance increase on my workload,
especially the behavior enabled in the #3 patch that allows dirty data
to be trimmed quickly during idle periods.

Reviewed-by tags would be appreciated so that these can be staged for 4.16.

I have additional changes coming in the next couple of days-- changes to
the closure code picked from kmo's bcachefs tree that both improve
performance and enhance correctness.  Just need a little more test and
to work on the commit comments some.

Thanks,

Mike
