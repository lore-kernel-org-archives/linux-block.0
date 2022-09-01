Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E214ECAAD1
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 12:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiIAMUd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 08:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiIAMUP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 08:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFA61BEB4
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662034792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQWbuU6Cl/+CpnjyGPlFLcxodi25TDRMfHUP0weRLN8=;
        b=a6MvWi5pFVqMXA0rCMsmQ4fN9Fm3oVTMeMDV0y9dH4nrZvAfbadCCT7Oqrjgwn5LCrWJu/
        W0GCTE3GGC+k9y4/jR5COp/cJ80+KYIoeR9u40kOPKMMVFlSp0veYMptOcYaff4crT8qfL
        A5vyJNBqdQA1LnldFlfuVFxfOKA13JQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-3g2LnupfNMyzN1musYbzeg-1; Thu, 01 Sep 2022 08:19:50 -0400
X-MC-Unique: 3g2LnupfNMyzN1musYbzeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7351C3C0E228;
        Thu,  1 Sep 2022 12:19:50 +0000 (UTC)
Received: from localhost (unknown [10.39.193.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B2E7C15BB3;
        Thu,  1 Sep 2022 12:19:49 +0000 (UTC)
Date:   Thu, 1 Sep 2022 13:19:49 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: Re: [PATCH V2 1/1] Docs: ublk: add ublk document
Message-ID: <20220901121949.GV7484@redhat.com>
References: <20220901023008.669893-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901023008.669893-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 01, 2022 at 10:30:08AM +0800, Ming Lei wrote:
> +ublk block device(``/dev/ublkb*``) is added by ublk driver. Any IO request
                   ^^^
Please insert a space between word and open bracket "(" everywhere.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

