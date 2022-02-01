Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A17C433EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Feb 2022 14:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbiBAONV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:13:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238761AbiBAONV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Feb 2022 09:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643724800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nrT/5L5qYMHdiH1OYbxOA/3ZZSuEj0xzzYPB+L6+4q8=;
        b=TbGoTYkXfEBP3ktG2YrM56VdiDIAOjRiGyjak4zZFlWnQUEzvFR9CbBHt3rJfvzW992bim
        h35nkEpB+iijzZhZRCtNVZmdb7Yr2bcbzq9z/iqjJEs6RsxpX2A7RKxCPGB4W2GX1hgWYC
        XezYeaZvayk7wOlcInTG4jaERJteQIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-wAukSB2EMM-ZNA2E0nQePQ-1; Tue, 01 Feb 2022 09:13:18 -0500
X-MC-Unique: wAukSB2EMM-ZNA2E0nQePQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EDB784DA41;
        Tue,  1 Feb 2022 14:13:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCA9277D52;
        Tue,  1 Feb 2022 14:13:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
References: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com, lsf-pc@lists.linux-foundation.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and fsconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1476916.1643724793.1@warthog.procyon.org.uk>
Date:   Tue, 01 Feb 2022 14:13:13 +0000
Message-ID: <1476917.1643724793@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> 
> If the ioctl debate goes against ioctls, I think configfd would present
> a more palatable alternative to netlink everywhere.

It'd be nice to be able to set up a 'configuration transaction' and then do a
commit to apply it all in one go.

David

