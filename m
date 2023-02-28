Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA1CC64EC7
	for <linux-block@archiver.kernel.org>; Tue, 28 Feb 2023 16:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjB1QF6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Feb 2023 11:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjB1QF6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2023 11:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC03A222DB
        for <linux-block@vger.kernel.org>; Tue, 28 Feb 2023 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677600313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/FPL9KWoan+aGF0+Fj8Ts+VkGVEiVbizSsqsZXIaWA=;
        b=LHEpBsaQnNKCzP7IgDo1Sh2Ow442lpuc0YRFZpEullpnyWemXb1FUqE7ongHmDh4KqSq00
        7StH55aN9Ty966kSUn8M6JgqtiwZeN4x6Djkaw9weCtH9LJKwHji48t89OE2KIIlNxH4CB
        KiTQELh4855CaUyK4V3mgQUJ0aO3xMY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-pqYcYWV1O6iGT5cUqPJIAw-1; Tue, 28 Feb 2023 11:05:09 -0500
X-MC-Unique: pqYcYWV1O6iGT5cUqPJIAw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 527A22817220;
        Tue, 28 Feb 2023 16:05:08 +0000 (UTC)
Received: from [10.22.8.29] (unknown [10.22.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84188492B0F;
        Tue, 28 Feb 2023 16:05:07 +0000 (UTC)
Message-ID: <d72e3ef4-f607-9a63-9f6d-b03084a8edf6@redhat.com>
Date:   Tue, 28 Feb 2023 11:05:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        kbusch@kernel.org, ming.lei@redhat.com
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
From:   John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20230210180033.321377-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/23 13:00, Kanchan Joshi wrote:
> 1. Command cancellation: while NVMe mandatorily supports the abort
> command, we do not have a way to trigger that from user-space. There
> are ways to go about it (with or without the uring-cancel interface) but
> not without certain tradeoffs. It will be good to discuss the choices in
> person.

As one of the principle authors of TP4097a and the author of the one NVMe controller implementation that supports the NVMe 
Cancel command I would like to attend LSF/MM this year and talk about this.

See my SDC presentation where I describe all of the problems with the NVMe Abort command and demonstrates a Linux host sending 
NVMe Abort and Cancel command to an IO controller:

https://www.youtube.com/watch?v=vRrAD1U0IRw


/John

