Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA05DC76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 23:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC0XU2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 19:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0XU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 19:20:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449EAE8;
        Mon, 27 Mar 2023 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N+OyLrU+4A8jmyCdWo96SNdqUn8faLNMQEozoY+O+Rs=; b=tyGjobv4NzlVSK/Tg7qsKh4Ksx
        siOpe2LW9dC6L/XowooMNSyqmPckCAW/9AoyV17Jhh1uVweMEb7HHxqau6/OCPwPAZ4WDb32DlnX0
        9ZVR9Cs8zzJDO2QcaGxl6rqbwKWNpySy8rPPxVN780E/LA8kN6zo+jTC4Yu/ykWZbdMQD08/DCBfQ
        LOp+tRH3LjPGrFtNpJ5mXXUIFBlLfqU2lxGcdE8cL55cPn8x+h+HRaNqc/jcLu2kKdkhaIisb93wS
        ilLl72VLqZ8E4NZTCt8JjdXBUxoiUlfNUmRpM2sqUhZeJhceigOwBacX98sa4hPhVD57JOeM6QIwk
        ZwT+UteA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgw8V-00CeAk-38;
        Mon, 27 Mar 2023 23:20:23 +0000
Date:   Mon, 27 Mar 2023 16:20:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: annotate bdev_disk_changed() deprecation with a
 symbol namespace
Message-ID: <ZCIkt3AnNSfvJH/G@infradead.org>
References: <20230327184410.2881786-1-mcgrof@kernel.org>
 <ZCIVx2UNN8VAWYAH@infradead.org>
 <ZCIgavqUnw0Z3A3t@bombadil.infradead.org>
 <ZCIiBHyrzDoTJPXT@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCIiBHyrzDoTJPXT@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 27, 2023 at 04:08:52PM -0700, Luis Chamberlain wrote:
> BTW is anyone aware of similar exports which are stuck in this way?

We have a few in fs code.   And there's thing like all kinds of very
low-level code exported that absolutely should only be used by kvm.
