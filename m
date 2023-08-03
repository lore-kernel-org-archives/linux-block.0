Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45094C001DF
	for <linux-block@archiver.kernel.org>; Thu,  3 Aug 2023 13:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjHCNJf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Aug 2023 09:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbjHCNJR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Aug 2023 09:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425E04683
        for <linux-block@vger.kernel.org>; Thu,  3 Aug 2023 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691067953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UErKKVaCtdS2O7EB//Zus61TQ5vBeF3I4I1lCVszpKU=;
        b=Vd7hew6Lb4K2g2Wbc3zq3JSLxTx52UlX5NC05IU2HnaSBMtsgTxY/DhGXyeCsqkNIZ8ssz
        U0LVxmVmoN28EdO2bjrUO2Z0SgLi7/QCNO4sCIv8X0zqRunPfDcO9wG+AMAiaUlWvq+N0P
        qCLjwR2wVPsA1yqQVGQC6GgjEYxExIo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-0lhyKOVvMjOvfa0yWrybcg-1; Thu, 03 Aug 2023 09:05:52 -0400
X-MC-Unique: 0lhyKOVvMjOvfa0yWrybcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFBA6830DAF;
        Thu,  3 Aug 2023 13:05:38 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61B3B1121325;
        Thu,  3 Aug 2023 13:05:38 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "dan.j.williams\@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma\@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang\@intel.com" <dave.jiang@intel.com>,
        "ira.weiny\@intel.com" <ira.weiny@intel.com>,
        "nvdimm\@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "axboe\@kernel.dk" <axboe@kernel.dk>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 1/1] pmem: set QUEUE_FLAG_NOWAIT
References: <20230731224617.8665-1-kch@nvidia.com>
        <20230731224617.8665-2-kch@nvidia.com>
        <x491qgmwzuv.fsf@segfault.boston.devel.redhat.com>
        <20230801155943.GA13111@lst.de>
        <x49wmyevej2.fsf@segfault.boston.devel.redhat.com>
        <0a2d86d6-34a1-0c8d-389c-1dc2f886f108@nvidia.com>
        <20230802123010.GB30792@lst.de>
        <x49o7jpv50v.fsf@segfault.boston.devel.redhat.com>
        <2466cca2-4cc6-9ac2-d6cd-cded843c44be@nvidia.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 03 Aug 2023 09:11:27 -0400
In-Reply-To: <2466cca2-4cc6-9ac2-d6cd-cded843c44be@nvidia.com> (Chaitanya
        Kulkarni's message of "Thu, 3 Aug 2023 03:24:36 +0000")
Message-ID: <x49cz04uv7k.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Chaitanya Kulkarni <chaitanyak@nvidia.com> writes:

> On 8/2/23 08:27, Jeff Moyer wrote:
>> So, I think with the change to return -EAGAIN for writes to poisoned
>> memory, this patch is probably ok.
>
> I believe you mean the same one I've=C2=A0 provided earlier incremental ..

Yes, sorry if that wasn't clear.

>> Chaitanya, could you send a v2?
>
> sure ...

and I guess I should have said v3.  ;-)

Cheers,
Jeff

