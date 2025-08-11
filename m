Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A61211A19
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923150; cv=none; b=MAB5kXjdRY5YLgL6fi6I1uoC+T2ckp5O5ly/VpQ1yxtStu1i3zAiCNgRUgDadtNCdZCiSIhmJqUU5vXp/dcUlPPxv+w2Nf7SS21auXE1rKMncjUVuYpjkA7/5lIcQNtrLvGvdVJnKxABxIuAnDafC0C3iNjezTbT6fNxw+SEUC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923150; c=relaxed/simple;
	bh=G2uVQpOf7PqwQRVRsPvTZPrzWtNui0toN/ABy8YeG4k=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ADNmzh8+Di60V48vxp4Mjt06D/gDe4hmU24N83w/AFbb7jf1Qsz7OnIMUfWSzegO8hW0Nkz/u/NxqBipsQv8nKQgqiss4dLlI5CQNjCwoLBq05nQbYZNpzEAI5wYKWfxZb+HreIE7azoMvEWF/AaNjEiimSsyTzZkXj+Z83Mpjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyUFsDMJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyUFsDMJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754923148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LVZ5P/C39XA0ox+6E/6LTbIRgWArxstBCbjGuW0XMo=;
	b=dyUFsDMJ3JBd43Ubuoc6qBznyFS2rPj0mCHT+ztjhS/sWVklCVPfN9vEllkUx48cPIDf3A
	3KRN3RgzkbKEMMEcOdYAIWCuZQNpbB3D4P5ZeY7hOJLrsRlxgNLM8AS6InO6Ac2sp8QmhC
	MXmDwqudFXqIt6cuByj+bIeacRVUyTc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-a3dCoIfjMky3DxWnzypurA-1; Mon,
 11 Aug 2025 10:39:01 -0400
X-MC-Unique: a3dCoIfjMky3DxWnzypurA-1
X-Mimecast-MFC-AGG-ID: a3dCoIfjMky3DxWnzypurA_1754923140
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 968E5180035F;
	Mon, 11 Aug 2025 14:38:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B98B319560AB;
	Mon, 11 Aug 2025 14:38:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250811-iot_iter_folio-v1-2-d9c223adf93c@codewreck.org>
References: <20250811-iot_iter_folio-v1-2-d9c223adf93c@codewreck.org> <20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org>
To: asmadeus@codewreck.org
Cc: dhowells@redhat.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
    Christian Brauner <brauner@kernel.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Andrew Morton <akpm@linux-foundation.org>,
    Maximilian Bosch <maximilian@mbosch.me>, Ryan Lahfa <ryan@lahfa.xyz>,
    Christian Theune <ct@flyingcircus.io>,
    Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] iov_iter: iov_folioq_get_pages: don't leave empty slot behind
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <385704.1754923134.1@warthog.procyon.org.uk>
Date: Mon, 11 Aug 2025 15:38:54 +0100
Message-ID: <385705.1754923134@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Dominique Martinet via B4 Relay wrote:

> From: Dominique Martinet <asmadeus@codewreck.org>
> 
> After advancing into a folioq it makes more sense to point to the next
> slot than at the end of the current slot.
> This should not be needed for correctness, but this also happens to
> "fix" the 9p bug with iterate_folioq() not copying properly.
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Acked-by: David Howells <dhowells@redhat.com>

