Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C21C433EF
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 16:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE8B610EA
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 16:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhKCQoa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhKCQoa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 12:44:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB684C061714;
        Wed,  3 Nov 2021 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=wL305YpMdGf01r1YkYJCQhU9IX
        FKqEKdw5uxClkcSIOys/GD/BtTQBjilWqF0bN9pdBAzSxStZ8zTEuLV8acPlQiXbwNNlmtc1DSnhQ
        bKZ0wkvBrd8BATICZuTILD8TruUXDegEyMS/7SM/6ovhyBRMgtRrhkGeUXVQJ9amXZrv8DYRZ7T8B
        p7PRtxxfxelo+E/TdoKQ5Q0hkc7BuutJwt37eIKAWuuw861f9ZmzTwG2GyU+vEQvmL8+0GyDLj5e4
        UPxACVShhN/VflAy7u8l5GcKb5wpZb/7WxGIBS5Oo9z7dk+LB/KDQUX9ukc7CLM1DSXtnKJ5PhcLV
        Qbt4M+TA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miJKi-005oS6-Ma; Wed, 03 Nov 2021 16:41:52 +0000
Date:   Wed, 3 Nov 2021 09:41:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] block: fix device_add_disk() kobject_create_and_add()
 error handling
Message-ID: <YYK70KPGLNE1Wqkg@infradead.org>
References: <20211103164023.1384821-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103164023.1384821-1-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
