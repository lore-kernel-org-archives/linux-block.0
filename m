Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A274AEB64DD
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 08:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjF2Il6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 04:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjF2Ik6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 04:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6021559F
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 01:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688027654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lcFzJ0h/r4o640kKx9oD5oKaAf0iz+R8cp1bGbk+mhI=;
        b=Y8Ibzx+Y7wDGXaP9ptojZzSSOC0tWwkwgATVGuq+Xt6EdpFzFM1zLx+mIEuLw22K/2NsZ5
        W11pgRnb3vSBVFuJ/FUmLbJorFUiWsrHKm7dclSVQ+DESl5m/S9AijeA/79wFSdSfS6hkB
        fjx/OCSrM632Dl6K3yJNM4WunPQ2miM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-P89DQgOTMauKEphGgInR0w-1; Thu, 29 Jun 2023 04:34:04 -0400
X-MC-Unique: P89DQgOTMauKEphGgInR0w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF498104458F;
        Thu, 29 Jun 2023 08:34:02 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F8C5492C13;
        Thu, 29 Jun 2023 08:33:32 +0000 (UTC)
Date:   Thu, 29 Jun 2023 16:33:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, dlemoal@kernel.org, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Vincent Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH v13 3/9] block: add emulation for copy
Message-ID: <ZJ1B1k0KifZrGRIp@ovpn-8-26.pek2.redhat.com>
References: <20230627183629.26571-1-nj.shetty@samsung.com>
 <CGME20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e@epcas5p1.samsung.com>
 <20230627183629.26571-4-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-4-nj.shetty@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Nitesh,

On Wed, Jun 28, 2023 at 12:06:17AM +0530, Nitesh Shetty wrote:
> For the devices which does not support copy, copy emulation is added.
> It is required for in-kernel users like fabrics, where file descriptor is

I can understand copy command does help for FS GC and fabrics storages,
but still not very clear why copy emulation is needed for kernel users,
is it just for covering both copy command and emulation in single
interface? Or other purposes?

I'd suggest to add more words about in-kernel users of copy emulation.

> not available and hence they can't use copy_file_range.
> Copy-emulation is implemented by reading from source into memory and
> writing to the corresponding destination asynchronously.
> Also emulation is used, if copy offload fails or partially completes.

Per my understanding, this kind of emulation may not be as efficient
as doing it in userspace(two linked io_uring SQEs, read & write with
shared buffer). But it is fine if there are real in-kernel such users.


Thanks,
Ming

