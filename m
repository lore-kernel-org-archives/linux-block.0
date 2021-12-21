Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA50C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 09:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhLUJeU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 04:34:20 -0500
Received: from verein.lst.de ([213.95.11.211]:46194 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236409AbhLUJeU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 04:34:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E7E3968AFE; Tue, 21 Dec 2021 10:34:16 +0100 (CET)
Date:   Tue, 21 Dec 2021 10:34:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH (resend)] brd: remove brd_devices_mutex mutex
Message-ID: <20211221093416.GA10573@lst.de>
References: <01fb7a16-fb97-b0e4-1c1f-aa42e7f68766@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fb7a16-fb97-b0e4-1c1f-aa42e7f68766@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
