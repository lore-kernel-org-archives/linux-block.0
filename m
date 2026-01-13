Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259B199920
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268333; cv=none; b=GSUf6kFUKCeQ91gMBJeNbr46kNy724joHflnaBQO0aWtdZG2/mWOMteHfPiQueHu5bNmpZiAj6ouudm781mZAHczPKqhUyFmUTm5rwv6/YvFidKsI+5MH71Wf+8oMs2dYeREndR2hTPu9p7uz+FXb0tXLD7pJ/Pvu2oAk9ZTENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268333; c=relaxed/simple;
	bh=NXHSkHe3iVnS1olUHMQJaogvyV6AraEA1+KZFiOZ6k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O10V7PfzrVTIf0EJk9+8gvTixIS+MlhrafZMlUrZxF6lZk+ufQGf34UZ60+OpgmKqw7C8wnpoKC3H27msFA7KwK9WbX5vUFCMAbv8y15aPi2mjRcp/y4H2sFkF73PwxJBVZdUn4PTPoSLWWHDh3/MQVpRrBQCJii9cOFF4eFgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDMGvkhi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDMGvkhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768268331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/Kyr6yrU4xkVhHnYfPvLyJuv/p1CdyA50g9jKnO2dw=;
	b=QDMGvkhiICgBK49hjqjd8YyxHSkLNa2cbxJxXsqI3K8jIcKReRZEPBv4hYgN/RuVkW4/Uf
	TC/NNqgZZbGVxYvtuKkmZAarpWIZyUEzXtYIzhsH5KzS0GRVIhaYGQuU5J7p7XCjo8sEZh
	AdONcFeny7p6AMeVuRQQb3apKEez37I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-35b7fl9SPCWAeTqoEOc-nQ-1; Mon,
 12 Jan 2026 20:38:47 -0500
X-MC-Unique: 35b7fl9SPCWAeTqoEOc-nQ-1
X-Mimecast-MFC-AGG-ID: 35b7fl9SPCWAeTqoEOc-nQ_1768268326
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9578B1800378;
	Tue, 13 Jan 2026 01:38:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C48B430001A2;
	Tue, 13 Jan 2026 01:38:42 +0000 (UTC)
Date: Tue, 13 Jan 2026 09:38:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Seamus Connor <sconnor@purestorage.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ublk: cancel device on START_DEV failure
Message-ID: <aWWiHe3f2FgsjYDC@fedora>
References: <20260112041209.79445-1-ming.lei@redhat.com>
 <20260112041209.79445-2-ming.lei@redhat.com>
 <CADUfDZp_4pOSAuPE52OWGU1q46bQHZL_9LLp8ANP3umZ1upmYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp_4pOSAuPE52OWGU1q46bQHZL_9LLp8ANP3umZ1upmYA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jan 12, 2026 at 08:52:31AM -0800, Caleb Sander Mateos wrote:
> On Sun, Jan 11, 2026 at 8:12 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > When ublk_ctrl_start_dev() fails after waiting for completion, the
> > device needs to be properly cancelled to prevent leaving it in an
> > inconsistent state. Without this, pending I/O commands may remain
> > uncompleted and the device cannot be cleanly removed.
> >
> > Add ublk_cancel_dev() call in the error path to ensure proper cleanup
> > when START_DEV fails.
> 
> It's not clear to me why the UBLK_IO_FETCH_REQ commands must be
> cancelled if UBLK_CMD_START_DEV fails. Wouldn't they get cancelled
> whenever the ublk device is deleted or the ublk server exits?

Good catch, DEL_DEV/STOP_DEV supposes to be capable of handling irrecoverable
START_DEV failure.

So this patch isn't needed.


Thanks, 
Ming

