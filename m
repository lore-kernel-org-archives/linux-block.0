Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F32EA147
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 02:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706313; cv=none; b=PexFL3Mti6RhkxXDiBGNIUEutZ66IvZL7HmE1H1cbm1S39jqi4N33TNMLsTXkJavsQMLQOm57H1VeQ4bgs6ewFQgNq8NzZ4MGHsbbcuUcoyM+cVfyhe1emPMPQ9Syzn9P2+L+5V4BzLacyqj4JDhNQEgDy4rs2WY4EYjdQKxcoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706313; c=relaxed/simple;
	bh=ZbAxezF3L3IXSVSc7yDQnZImTRzdDuotgE0Z+fKriH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBcWk0tXeW2l8cavQC6ssuVWoQzEna+YgejXX5ge9jaLS3PVbyEDWCjwScp+0ENqgxyQAOvABCYN0SVsZnDG7wlYxZdomfxkWEQHYFxchKUbWDHpHvUHmEJlrV6v4N0yF1KLTEH4SC5drtvGSZ2Yy8kLy1ycQO8q69htembFbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YeiyK4UL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeiyK4UL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761706310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkESQ9g+QJaCYqatuTMLYF2kEm3QnYoy+kX4vua6hGs=;
	b=YeiyK4ULDmO0earFSNS4RJJy5QbFp0Ga4C1TUjv6xrTWjF3OQyiVRsAK/WVteQpyms7hSc
	sWukqkf0DqUVVRLvOlQ+sCsk7aUgtRG1aayNje8H+k11BQkhHfUKHLYNrADn6PWemNnc+m
	eNo3IS8EL05bG7m8HPM8XCCDqs99C+U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-jlAwDizuOwiLnHFhsnr6Bw-1; Tue,
 28 Oct 2025 22:51:48 -0400
X-MC-Unique: jlAwDizuOwiLnHFhsnr6Bw-1
X-Mimecast-MFC-AGG-ID: jlAwDizuOwiLnHFhsnr6Bw_1761706307
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFF9218002C1;
	Wed, 29 Oct 2025 02:51:46 +0000 (UTC)
Received: from fedora (unknown [10.72.120.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04CB31800353;
	Wed, 29 Oct 2025 02:51:42 +0000 (UTC)
Date: Wed, 29 Oct 2025 10:51:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V2 3/5] ublk: use flexible array for ublk_queue.ios
Message-ID: <aQGBOLwiqKILxIAB@fedora>
References: <20251028085636.185714-1-ming.lei@redhat.com>
 <20251028085636.185714-4-ming.lei@redhat.com>
 <CADUfDZr-4iq752TrPjb8a9u_Wsa73dFMz_Z5_P8rmJjPUe5dGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZr-4iq752TrPjb8a9u_Wsa73dFMz_Z5_P8rmJjPUe5dGQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Oct 28, 2025 at 02:52:25PM -0700, Caleb Sander Mateos wrote:
> On Tue, Oct 28, 2025 at 1:57 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Convert ublk_queue to use DECLARE_FLEX_ARRAY for the ios field and
> > use struct_size() for allocation, following kernel best practices.
> >
> > Changes in this commit:
> >
> > 1. Convert ios field from "struct ublk_io ios[]" to use
> >    DECLARE_FLEX_ARRAY(struct ublk_io, ios) for consistency with
> >    modern kernel style.
> 
> Documentation/process/deprecated.rst suggests that
> DECLARE_FLEX_ARRAY() is discouraged except in the niche cases when
> it's necessary (which don't apply here). Or am I misunderstanding
> something?

You are right, DECLARE_FLEX_ARRAY is only needed:

```
when the flexible array is either alone in a struct or is part of a union.
```

> However, struct ublk_io ios[] does seem like a good use
> case for __counted_by().

Good point!

Thanks, 
Ming

