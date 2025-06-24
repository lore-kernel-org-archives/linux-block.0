Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69AF8F6E
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 01:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750727600; cv=none; b=g5POe2G8vFEzIjk4pqjWbKdYtXOFNSfVIVg2+URNkSVngamtFos0WrOQouuXJiMH2th/mtnXPStCizlQ7zjXzVxPEhgKjN3YD6hojuVNmoimvaHZAiM9S7ziNonpJ22IwfFk8WoraZ/iknWg4n/zkPTylue5egVttSzfBkTjzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750727600; c=relaxed/simple;
	bh=7SZqCmc58hF7gyqmXbSFNlt1dazvZmzdUIkVjYO5tNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfUBocdHZaW+1+jP2REVKB+TU75K5ZQoUTAuEziDy5KM1gk++UH+N2MmGs2LSaXPIApS7M5USFzrzIFm64H2vt0OCkJAArr7N0p0RtmQzNYmalaSXFd6GC0+t90ILcbBs5eSuhRZXut/PbrIbqBgoghlktLOVI+cne9ipifnD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQQu6rmK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQQu6rmK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750727597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/FEJLFME7AelZZ/uYkUfqC59F+YEUrAf5MPnhav9aLE=;
	b=gQQu6rmKIo6Wtwif2ptHzH76SNdit5wGZOxjVlLJDnmYEgCz/AOkST9kwshBl7m2/e8Rdz
	iBQS8DmV5wm4+uU4EuJUlVAtOzMhkgXIzgKVzzDtvqzy6nWzv735TblZEW+DoqqQulwe7I
	v+D27E/bC22kLE0fQbdFRLG2kywJx8A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-fUY88uN9OYKkV5mQtZRQLg-1; Mon,
 23 Jun 2025 21:13:13 -0400
X-MC-Unique: fUY88uN9OYKkV5mQtZRQLg-1
X-Mimecast-MFC-AGG-ID: fUY88uN9OYKkV5mQtZRQLg_1750727592
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2947180028C;
	Tue, 24 Jun 2025 01:13:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.90])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83C2B195608D;
	Tue, 24 Jun 2025 01:13:08 +0000 (UTC)
Date: Tue, 24 Jun 2025 09:13:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 2/2] selftests: ublk: don't take same backing file for
 more than one ublk devices
Message-ID: <aFn7n_GN4y3Y1WgD@fedora>
References: <20250623011934.741788-1-ming.lei@redhat.com>
 <20250623011934.741788-3-ming.lei@redhat.com>
 <CADUfDZq4_463nageZgzH8hMtr_gTMhvMxHfVCSuzVoBCWbgsww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZq4_463nageZgzH8hMtr_gTMhvMxHfVCSuzVoBCWbgsww@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jun 23, 2025 at 10:54:58AM -0700, Caleb Sander Mateos wrote:
> On Sun, Jun 22, 2025 at 6:19 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Don't use same backing file for more than one ublk devices, and avoid
> > concurrent write on same file from more ublk disks.
> >
> > Fixes: 8ccebc19ee3d ("selftests: ublk: support UBLK_F_AUTO_BUF_REG")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  tools/testing/selftests/ublk/test_stress_03.sh | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
> > index 6eef282d569f..3ed4c9b2d8c0 100755
> > --- a/tools/testing/selftests/ublk/test_stress_03.sh
> > +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> > @@ -32,22 +32,23 @@ _create_backfile 2 128M
> >  ublk_io_and_remove 8G -t null -q 4 -z &
> >  ublk_io_and_remove 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}" &
> >  ublk_io_and_remove 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > +wait
> 
> Why is wait necessary here? It looks like __run_io_and_remove, which
> is called from run_io_and_remove, already ends with a wait. Am I
> missing something?

All tests share the three backing files, this way just avoids concurrent
write to the same file from each test/ublk device.



Thanks,
Ming

