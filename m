Return-Path: <SRS0=mx3V=TD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9FCC04AAA
	for <linux-block@archiver.kernel.org>; Fri,  3 May 2019 10:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9790A2089E
	for <linux-block@archiver.kernel.org>; Fri,  3 May 2019 10:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfECKmb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 May 2019 06:42:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfECKmb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 May 2019 06:42:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E02281DE0;
        Fri,  3 May 2019 10:42:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F01F60BF7;
        Fri,  3 May 2019 10:42:30 +0000 (UTC)
Date:   Fri, 3 May 2019 12:42:27 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     util-linux@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] lib/loopdev.c: Retry LOOP_SET_STATUS64 on EAGAIN
Message-ID: <20190503104227.ga56ffjkrm2gno7h@ws.net.home>
References: <20190503082819.23112-1-romain.izard.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503082819.23112-1-romain.izard.pro@gmail.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 03 May 2019 10:42:31 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 03, 2019 at 10:28:19AM +0200, Romain Izard wrote:
> +	do {
> +		err = ioctl(dev_fd, LOOP_SET_STATUS64, &lc->info);
> +	} while (err && errno == EAGAIN);

 Would be better to use any delay in the loop? For example after
 EAGAIN read/write we use usleep(250000).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
