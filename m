Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903D336EE8
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168252; cv=none; b=WcYBl7XVTp2/23hVEGKOe2xuWbb5TFQM/lLNMhVEhaWQVZHGsQDz6tmyeT1yGLBokNTMyCKoPP72hWRd3QFQj/vYfZuKCo6yhDXPo1PEtQB1ud3lI6i9eC7PqSmN7XEsNZf9CfaX7OB5DBEA7TpApuCfXkmEwb+NebpAzLTjlCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168252; c=relaxed/simple;
	bh=e259cDOR2x8y2PNY1VZBUyduw1cVUirqqxjpTqnIsNA=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:Content-Type:
	 From:Date:Message-ID; b=JiLjOkPr5KWE/J+EhBi21beqFKM7kotOW097Dug5MA1rmVGNF/JvBR4aPFH1Hq9MnfCZuqI9KdDLo6prZZcwL+2ywxHjn1o6TvCiFrIhJT8Vmdp+go0J4s09mOKvoorjR+9DEqJ8RTmPeucpvDlULwvbXcvwGgk756Fu6DZj8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkyVd1NO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkyVd1NO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769168247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xs0Vg5nji+dUGsW7zgyizne5BIyRwd0ccrRHXi+VavY=;
	b=AkyVd1NOJMhkIYgiy3NFvv0LdBDETRExl4bJueTt98VYtRZOcRpRr0Ia2F1L4KHZyxfRug
	CLE+r+iLWLfJwggx4sQUaR2QlY/EynAxoi94UbXw7d7w4O4SgHKqOEnoM7an9LlAL4vZW3
	hdKLUt8HPhZ+gLQb9KoYvBSW2UQJLbs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-cxzqkuf4OhGk9R5ZCIISSw-1; Fri,
 23 Jan 2026 06:37:23 -0500
X-MC-Unique: cxzqkuf4OhGk9R5ZCIISSw-1
X-Mimecast-MFC-AGG-ID: cxzqkuf4OhGk9R5ZCIISSw_1769168241
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D8AD1800342;
	Fri, 23 Jan 2026 11:37:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDB1918001D5;
	Fri, 23 Jan 2026 11:37:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20260119074425.4005867-4-hch@lst.de>
References: <20260119074425.4005867-4-hch@lst.de> <20260119074425.4005867-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
    Christian Brauner <brauner@kernel.org>,
    "Darrick J. Wong" <djwong@kernel.org>,
    Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
    Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
    linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs helper from bio code
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1754439.1769168181.1@warthog.procyon.org.uk>
From: David Howells <dhowells@redhat.com>
Date: Fri, 23 Jan 2026 11:37:17 +0000
Message-ID: <1754475.1769168237@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Christoph Hellwig <hch@lst.de> wrote:

> +static unsigned int get_contig_folio_len(struct page **pages,
> +		unsigned int *num_pages, size_t left, size_t offset)
> +{
> +	struct folio *folio = page_folio(pages[0]);

You can't do this.  You cannot assume that pages[0] is of folio type.
vmsplice() is unfortunately a thing and the page could be a network read
buffer.

David

