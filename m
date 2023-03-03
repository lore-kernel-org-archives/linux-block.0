Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA0EC6FA8E
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 02:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCCCzB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 21:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCCCzB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 21:55:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0799213510
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 18:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677812055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=On0X7jfu4Kkz5jhhXkidOS2W/o76f20Fry218Xber/4=;
        b=WdhGo6ZPaHNq5b0dQc+vyqBrFLja8nUPF2iFJirVSf0oGL7vIWIbwGoILdDNvS1fQU1TZi
        W5qwoG/8+jPHZjbuwSVYY6i4hHq3ZgSKAOhACB8aOzGBjTTznTK+GkAlMZfKkKqEHGey3i
        FQ9O2LtbhXuPmHawy5F81rNU28X5dIY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-ilq3GhXiNH6bbuyY-Sy4nQ-1; Thu, 02 Mar 2023 21:54:10 -0500
X-MC-Unique: ilq3GhXiNH6bbuyY-Sy4nQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91D523811F20;
        Fri,  3 Mar 2023 02:54:09 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E7A6492C3E;
        Fri,  3 Mar 2023 02:54:03 +0000 (UTC)
Date:   Fri, 3 Mar 2023 10:53:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Xiao Ni <xni@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org, Nigel Croxon <ncroxon@redhat.com>
Subject: Re: The gendisk of raid can't be released
Message-ID: <ZAFhRj8YVpiO3b5g@T590>
References: <CALTww28pEdW+f1SaXrG7Umf8uA6fAc9io-WKb_W8mVxEzW8EzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALTww28pEdW+f1SaXrG7Umf8uA6fAc9io-WKb_W8mVxEzW8EzA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 02, 2023 at 11:51:59PM +0800, Xiao Ni wrote:
> Hi Christoph
> 
> There is a regression problem which is introduced by 84d7d462b16d
> (blk-cgroup: pin the gendisk in struct blkcg_gq).

The above commit has been reverted, can you test the latest linus tree?


Thanks,
Ming

