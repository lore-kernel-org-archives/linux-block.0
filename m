Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32316C636CC
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 12:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjBOMYa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 07:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjBOMY3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 07:24:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AFB34306
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 04:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676463822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3Cz4qPfh6SVniqMxzACvEnXSN4Vm6rhHNCN0GEcnwU=;
        b=ihu1TWGI9o+N9LDiEQ9TO6/wDV28Y3/PygGcUW4HXDMDYFZma/2vno+ag/hI5Si2hxoh8B
        67ct821kq/qk++Mkg55uy5C+6xT9heATru0lhtpouoLwJWfO7jck38Bnk/z8AG77wyV5Lo
        csVDq724KVXMOchIeR3pOeVYdUgovS0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-VLzuZdXQN8OcPjdgrnXQkg-1; Wed, 15 Feb 2023 07:23:39 -0500
X-MC-Unique: VLzuZdXQN8OcPjdgrnXQkg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71C503847980;
        Wed, 15 Feb 2023 12:23:38 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E0C7492B0E;
        Wed, 15 Feb 2023 12:23:38 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 31FCNcAQ007819;
        Wed, 15 Feb 2023 07:23:38 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 31FCNbeX007815;
        Wed, 15 Feb 2023 07:23:37 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 15 Feb 2023 07:23:37 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Yang Shi <shy828301@gmail.com>
cc:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [v2 PATCH 0/5] Introduce mempool pages bulk allocator
 and use it in dm-crypt
In-Reply-To: <20230214190221.1156876-1-shy828301@gmail.com>
Message-ID: <alpine.LRH.2.21.2302150716120.5940@file01.intranet.prod.int.rdu2.redhat.com>
References: <20230214190221.1156876-1-shy828301@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Tue, 14 Feb 2023, Yang Shi wrote:

> 
> Changelog:
> RFC -> v2:
>   * Added callback variant for page bulk allocator and mempool bulk allocator
>     per Mel Gorman.
>   * Used the callback version in dm-crypt driver.
>   * Some code cleanup and refactor to reduce duplicate code.
> 
> rfc: https://lore.kernel.org/linux-mm/20221005180341.1738796-1-shy828301@gmail.com/

Hi

This seems like unneeded complication to me. We have alloc_pages(), it can 
allocate multiple pages efficiently, so why not use it?

I suggest to modify crypt_alloc_buffer() to use alloc_pages() and if 
alloc_pages() fails (either because the system is low on memory or because 
memory is too fragmented), fall back to the existing code that does 
mempool_alloc().

Mikulas

