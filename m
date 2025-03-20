Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981611E2845
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481871; cv=none; b=Iy6XSl3nN3WsP+cRzrfGP7vGMr5pqH1cbbko++NYCsBjH1s6H1pNYEqxccHvGnfXRQbSDmheQLMXVWbJ5zyKq9UXgTyQLeyNpUGAbNGhOsCwyscWgSRFnNABKEwdCOsJbfoVbo/BzDSsALwpEPTxKLtmEzXers8V5j3xwyG0PDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481871; c=relaxed/simple;
	bh=zJ2N5Sje1TsFpx1txcvkGVs9M1jCDKPalNO6wcsqJzA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=GVMw2H1KWbMEoXHFxrw5LQZk393oX5eejwWAAqdtrtphVR5+oXcsWqkRP6LST771WhTzXp4/S8lVHsy7QGq2JcnN909WY5g/LLpXC2w81+BkLRgpn93tS7Z8+iEh0rakwoijkgAcTRk39WpfuXG1iWrVAbYHwEXP1ij3Nkbm7bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6XMtLCr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6XMtLCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742481868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EL9f1EpuEC79rGyi/SbJ4e42e9KhE2EM/hh13H42cIk=;
	b=O6XMtLCrTpIkfDZslssm++FLJ0VSVJqz19RF4VwOOTClFGNwRSUKKd+hYzVDRrMV79GtAn
	1/EPNIPozoKyvq3u2xXH8oHid72oEzVwMJ3QUd+Qy1SJakMX6WpvlUDr9B4Y2OzkTz5RQ4
	AZqfjtNdhG3067RCom6iSr3K5wL58LY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-kjbRVno5Nfm19xQJikLQEg-1; Thu,
 20 Mar 2025 10:44:22 -0400
X-MC-Unique: kjbRVno5Nfm19xQJikLQEg-1
X-Mimecast-MFC-AGG-ID: kjbRVno5Nfm19xQJikLQEg_1742481861
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09E731800266;
	Thu, 20 Mar 2025 14:44:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A473218001D4;
	Thu, 20 Mar 2025 14:44:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b1108a2b01c693430abb4566b1bd644a5985ecf6.camel@ibm.com>
References: <b1108a2b01c693430abb4566b1bd644a5985ecf6.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-23-dhowells@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 22/35] libceph, rbd: Convert ceph_osdc_notify() reply to ceph_databuf
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3172345.1742481855.1@warthog.procyon.org.uk>
Date: Thu, 20 Mar 2025 14:44:15 +0000
Message-ID: <3172346.1742481855@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> >  		} else if (!completion_done(&lreq->notify_finish_wait)) {
> > -			struct ceph_msg_data *data =
> > -			    msg->num_data_items ? &msg->data[0] : NULL;
> > -
> > -			if (data) {
> > -				if (lreq->preply_pages) {
> > -					WARN_ON(data->type !=
> > -							CEPH_MSG_DATA_PAGES);
> > -					*lreq->preply_pages = data->pages;
> > -					*lreq->preply_len = data->length;
> > -					data->own_pages = false;
> > -				}
> > +			if (msg->num_data_items && lreq->reply) {
> > +				struct ceph_msg_data *data = &msg->data[0];
> 
> This low-level access slightly worry me. I don't see any real problem
> here. But, maybe, we need to hide this access into some iterator-like
> function? However, it could be not feasible for the scope of this patchset.

Yeah.  This is something that precedes my changes and I think it needs fixing
apart from it.

David

