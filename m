Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1C9A920
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416082; cv=none; b=Az5RZkKia+mztLd7smLEABhkBSX904aIYjVDV1LmbnNDxjaxIDk7MW2TO4RkJXXQQita5laFo6ZAhFHJC4xqH1pJjTYOAPCq1EXq/lCl6BVkRSBq2v0le8VpNsFusUFgqKd+vsqGwJYZbarTbJ/IFjNcPwQHzWAr+ndp9T5wCiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416082; c=relaxed/simple;
	bh=GMzjbeqX79RFse9m/ZE+RXI5XnroSMYa4+DZxoBi8yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mi5VARLtzOd4VZurFxZdXagzyaGpS7yxJFJPnw4BA9ISwLq+SgUUNnePYoDzYzkyN+9ST1dUTH1NJfki1dpiqDtMqRfrJhLsMERGL3/CY5nTyFp/Z1ZtT70T97rt2mHu9pl4BMK+j++UIgJncaOI4B7miN+88hVBCqpOZSqIgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boImEzkO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boImEzkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752416079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xsyobdvziat8r/6Qi79jhUbkcrPwgikClXT7vdqzBkw=;
	b=boImEzkOtv4EkdwmOmcAktLHqjeVv/V69Hreb/HceQivKFKK/Tqv2kCQ77ToXVyj05W1w6
	/UGP/pHInqf07a228DYkAOz47tSI84A5UxBPocRHfyFKpcI6L8J3gZeZhZjTGV85LA0l6r
	ri3VOktNlg5YVhFWiYpwj1/4xhYTcFg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-Icvl7gMmPTemVeby--B1hg-1; Sun,
 13 Jul 2025 10:14:36 -0400
X-MC-Unique: Icvl7gMmPTemVeby--B1hg-1
X-Mimecast-MFC-AGG-ID: Icvl7gMmPTemVeby--B1hg_1752416075
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F25DB180028C;
	Sun, 13 Jul 2025 14:14:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.36])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EEED19560A3;
	Sun, 13 Jul 2025 14:14:31 +0000 (UTC)
Date: Sun, 13 Jul 2025 22:14:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 08/16] ublk: remove ublk_commit_and_fetch()
Message-ID: <aHO_O1AdjqzMlu_h@fedora>
References: <20250702040344.1544077-1-ming.lei@redhat.com>
 <20250702040344.1544077-9-ming.lei@redhat.com>
 <CADUfDZo9SADywa6a_D5ZjwoU+3Y14CTg7Y1Ywhf-5Hsnu=fCyQ@mail.gmail.com>
 <aG5ZAQs4TSHovUyd@fedora>
 <CADUfDZoEKtuLoh2rKrFP2TnEadd5U2jtmb5WPtdP27-0HhNHXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoEKtuLoh2rKrFP2TnEadd5U2jtmb5WPtdP27-0HhNHXg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Jul 11, 2025 at 10:05:13AM -0400, Caleb Sander Mateos wrote:
> On Wed, Jul 9, 2025 at 7:57 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Jul 08, 2025 at 09:27:57AM -0400, Caleb Sander Mateos wrote:
> > > On Wed, Jul 2, 2025 at 12:04 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > Remove ublk_commit_and_fetch() and open code request completion.
> > > >
> > > > Now request reference is stored in 'ublk_io', which becomes one global
> > > > variable, the motivation is to centralize access 'struct ublk_io' reference,
> > > > then we can introduce lock to protect `ublk_io` in future for supporting
> > > > io batch.
> > >
> > > I didn't follow this. What do you mean by "global variable"?
> >
> > ublk server can send anything to driver with specified tag if batch io
> > extension is added and per-io task is relaxed, then 'ublk_io' instance can be
> > visible to any userpsace command, which needs protection, looks like one
> > global variable.
> >
> > If reference is stored in request pdu, things becomes more like local
> > variable, since the early ublk_io flag check guarantees that concurrent
> > access can't reach 'request'.
> 
> "global variable" means something specific in C, so I would avoid
> using it here to refer to something else. How about something like the
> following?
> 
> Consolidate accesses to struct ublk_io in
> UBLK_IO_COMMIT_AND_FETCH_REQ. When the ublk_io daemon task restriction
> is relaxed in the future, ublk_io will need to be protected by a lock.
> Unregister the auto-registered buffer and complete the request last,
> as these don't need to happen under the lock.

OK.


Thanks,
Ming

