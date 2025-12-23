Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24821CC4F
	for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456302; cv=none; b=s5p7FHCtXJeq/AUAsowdduixFZjTNKE9SXGBzXPGImtFFWx0UG9rDAH9eG0sLfI/ecEqCp1Ghst9eTJ1Y0ku5pHRPt7RhAzBnxEvaye6xEfYblcA6rGsBbWDqbTcBXn1q8JrBUZmdHRg+uFnDN8mv2CgFrzOpMxwkoEjaZsCk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456302; c=relaxed/simple;
	bh=CZ0nyKcSyixC2Gl9g2XHAXsK0dw1BKDJqHwdH/S5rEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZwU2N0hwS+PC2jc1H91Lv9vBM4VFtzOmgklDn+TKHs/RwwKWIz9L1GKKesCYm+vpOuKIEfTveh4tmSxRd77lUygLxJqbx+J9zfH0BGM9LULMYL/lxYpL0RvhJ1DcXDqNM3tFQqhgyupUtHt/WTKn6pBeYZ+I5hacooMtyxu7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvSr0c5i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvSr0c5i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766456299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gK4AJD6G3WoC70iH1jDcDAZ+Y5oxp/uHuTBogdOKn+o=;
	b=NvSr0c5i7R0g7HfrjZYMJ+qW52A7go6tLU5Zsr2Sb8nHJC2JjxyWmEbmJuFLL+dQ7j5lz4
	gAPBpOPklgagmegE2dhnGGtvnlpztBdi0Q3ReEDEUhU7Ti9CsvWIY/oB9OikHnzdL4wsQW
	19muCxnyApZddOhJOQwnFZIngo0djf8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-WEhLtcc-OpKERGbQfrn2Fw-1; Mon,
 22 Dec 2025 21:18:13 -0500
X-MC-Unique: WEhLtcc-OpKERGbQfrn2Fw-1
X-Mimecast-MFC-AGG-ID: WEhLtcc-OpKERGbQfrn2Fw_1766456292
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6EF41800343;
	Tue, 23 Dec 2025 02:18:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.97])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 688C630001A2;
	Tue, 23 Dec 2025 02:18:08 +0000 (UTC)
Date: Tue, 23 Dec 2025 10:18:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: Re: [PATCH 3/3] selftests/ublk: fix Makefile to rebuild on header
 changes
Message-ID: <aUn73Gb0c8gVjVWV@fedora>
References: <20251221164145.1703448-1-ming.lei@redhat.com>
 <20251221164145.1703448-4-ming.lei@redhat.com>
 <CADUfDZq8eMgJWbwD9uFomjmv14PtDf8npsk3_uCUY8=OHuh-mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZq8eMgJWbwD9uFomjmv14PtDf8npsk3_uCUY8=OHuh-mQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Dec 22, 2025 at 11:48:37AM -0500, Caleb Sander Mateos wrote:
> On Sun, Dec 21, 2025 at 11:42 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add header dependencies to kublk build rule so that changes to
> > kublk.h, ublk_dep.h, or utils.h trigger a rebuild.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  tools/testing/selftests/ublk/Makefile | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> > index eb0e6cfb00ad..fb7b2273e563 100644
> > --- a/tools/testing/selftests/ublk/Makefile
> > +++ b/tools/testing/selftests/ublk/Makefile
> > @@ -53,8 +53,10 @@ TEST_GEN_PROGS_EXTENDED = kublk
> >
> >  include ../lib.mk
> >
> > -$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c \
> > -       fault_inject.c
> > +LOCAL_HDRS += kublk.h ublk_dep.h utils.h
> > +
> > +$(TEST_GEN_PROGS_EXTENDED): $(LOCAL_HDRS) \
> > +       kublk.c null.c file_backed.c common.c stripe.c fault_inject.c
> 
> I'm not really familiar with the selftests Makefile magic, but will
> this end up passing the header files as source files to the cc command
> too? That seems a bit wasteful, but probably won't cause any

I won't do this way, just setup build dependency on local header, please
see `$(OUTPUT)/%:%.c $(LOCAL_HDRS)` in `../lib.mk`.

> compilation failures. Maybe it would be better to explicitly list the
> .c files to pass to the cc command, which seems to be what most of the
> other selftests do.

It can be done in the following way:

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index eb0e6cfb00ad..06ba6fde098d 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -51,10 +51,10 @@ TEST_PROGS += test_stress_07.sh

 TEST_GEN_PROGS_EXTENDED = kublk

+LOCAL_HDRS += $(wildcard *.h)
 include ../lib.mk

-$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c \
-       fault_inject.c
+$(TEST_GEN_PROGS_EXTENDED): $(wildcard *.c)

 check:
        shellcheck -x -f gcc *.sh


Thanks,
Ming

