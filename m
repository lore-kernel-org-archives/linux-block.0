Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B063A1BA
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682245; cv=none; b=S2pB4yrjDaPbDQeEV6+YndqB03fmKAgKt5gvleqC39BQesEU5Ul0kbqk6mS8YZ+aRvFNX2dXnTR1NxNMpCHrmjxohUrxgiEhY/xKuInuAIf5Z6u18xCw/D2EXujRMrGSfT+XhEpE6sCX/kEBUweXagyx14DftkMPgxjxyx9ho2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682245; c=relaxed/simple;
	bh=H0Z/g0gOCcHkZiLanWGJaHBUD6aWNlg79rRr4JYU5N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eI9WLoMz3NwuTT68qQd090JDGpBBIS3rv1aQPcR74Aj5HeYy0E0sV2MNAfXGUaEHc9tvp2/BWpZIKA1PHjU1Y0deD7/W07HWPTTZdNlwKaxk7KneSgjbpcSYAn/naULZQgZaJdeek34I6lV/r2qY03Ux7rxY6NYnWubdncYd5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyUYZ1g5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyUYZ1g5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744682242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N4gXYz7FiLXkRrHNZH0NFFE+EPF8BBq/W3cwMDAFf2I=;
	b=YyUYZ1g5T+YnoZZVPYf5OmgUCZMkmGOUUWKw517UdzRY6D7NR0DmGdhzgz0WatOUkXkbK0
	mNUZxNg60xykRT/0FFHOwmk4S1xrpZDcJF9aj5vzxtD51anZqYaF0oungze5+r2xNcPVcu
	FzlB2cBYr8DK80OTgp8uirPHS6BcjGc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-RzTDNtt9NnqKQqA3Uu9ETA-1; Mon,
 14 Apr 2025 21:57:18 -0400
X-MC-Unique: RzTDNtt9NnqKQqA3Uu9ETA-1
X-Mimecast-MFC-AGG-ID: RzTDNtt9NnqKQqA3Uu9ETA_1744682237
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 578A5195608A;
	Tue, 15 Apr 2025 01:57:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ED4B19560AD;
	Tue, 15 Apr 2025 01:57:13 +0000 (UTC)
Date: Tue, 15 Apr 2025 09:57:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 9/9] selftests: ublk: add generic_06 for covering fault
 inject
Message-ID: <Z_289Zd3c_MSl7vl@fedora>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-10-ming.lei@redhat.com>
 <Z/1ztR/DKOGgrdfW@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/1ztR/DKOGgrdfW@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Apr 14, 2025 at 02:44:37PM -0600, Uday Shankar wrote:
> On Mon, Apr 14, 2025 at 07:25:50PM +0800, Ming Lei wrote:
> > From: Uday Shankar <ushankar@purestorage.com>
> > 
> > Add one simple fault inject target, and verify if it can be exited in
> > expected period.
> 
> What "it" refers to is unclear. Maybe say "verify if an application
> using ublk device sees an I/O error quickly after the ublk server dies?"

Looks good, will change commit log to the above words.


Thanks,
Ming

