Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF90139E
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743996753; cv=none; b=Y/DfkhGpEePS39QV8GIc3m4AobP0fAe7ofb/kEOGOsNCt3x9RZnM+OxNtwoqi6NGZWYIEsktZEZgrpMJwL6NQ0KiwWbuUNaG7yXVGxeEXp/8cdoWMxfHVMVt8JAXHTcDLxOMuJV46h/dfxIIb09HSkIWm1RauSUwEOaashJHw60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743996753; c=relaxed/simple;
	bh=w8SFWSTMHrwftdkhkCS6jWXnLo4AHqbyailnB8IvYLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep6cTBnV8puwjCSEZ9DWcG39O0jRErDlA7hB9qRbaOKuJEM0WMTwA5oTWe7ToPD+PUDPjURqEd8Ok/Dtdrdr+neiN7yuqkDJ3JXwJVa0M/P8gVGELHpcEBmT4KqQY/9NatbwNClpuY+zzOH5vqL2lkRATY49Wc1V4NQCoLidScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgDa9UhG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgDa9UhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743996750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh1cgK3Z2jWUBEG7x5kiEtWo1v+NqYUnMWFDidS7eIU=;
	b=bgDa9UhGnJ/hoe1KQNlHcNXK0digmdkkDLDr3qtzwFRL4hQHLxxRd/Ap9OKzsggxQPdMmb
	nSSYNzA2ZpXqI9M6mttg1WCJoxWvMnslecInK895ywzQpZFaHsT5j9FyM409q+IbpiyPrp
	TtY4qY/ohsYsDMrvki+lMe1D0ppMXDk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-Jg9FRQT9O1q3U79ozgK0DQ-1; Sun,
 06 Apr 2025 23:32:27 -0400
X-MC-Unique: Jg9FRQT9O1q3U79ozgK0DQ-1
X-Mimecast-MFC-AGG-ID: Jg9FRQT9O1q3U79ozgK0DQ_1743996746
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CA6D1800349;
	Mon,  7 Apr 2025 03:32:26 +0000 (UTC)
Received: from fedora (unknown [10.72.120.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C9CF1801752;
	Mon,  7 Apr 2025 03:32:22 +0000 (UTC)
Date: Mon, 7 Apr 2025 11:32:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] ublk: Add UBLK_U_CMD_SET_SIZE
Message-ID: <Z_NHOlakYO22Q7JR@fedora>
References: <20250331135449.3371818-1-jholzman@nvidia.com>
 <SJ1PR12MB63639AFCE9BC8C1EC4D28795B1AE2@SJ1PR12MB6363.namprd12.prod.outlook.com>
 <Z_Cana4Ibs8zN_wA@fedora>
 <07db9a34-c5de-4ea4-afc5-e740e87923c5@nvidia.com>
 <Z_NDGl6Le--pPBxR@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_NDGl6Le--pPBxR@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 07, 2025 at 11:14:34AM +0800, Ming Lei wrote:
> On Sun, Apr 06, 2025 at 11:17:05PM +0300, Jared Holzman wrote:
> > Hi Ming,
> > 
> > On 05/04/2025 5:51, Ming Lei wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > Hello Jared,
> > > 
> > > On Thu, Apr 03, 2025 at 12:37:11PM +0000, Jared Holzman wrote:
> > > > Apologies if this is a dup, but I am not seeing the original mail on the mailing list archive.
> > > I guess it is because the patch is sent as html, instead of plain test,
> > > please follow the patch submission guide:
> > > 
> > > https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
> > 
> > Sorry about that, I originally sent the mail using git send-mail, but our
> > internal smtp relay does not support outside addresses. I then tried
> > forwarding it from Outlook and it decided to add HTML without telling me.
> > 
> > I'm using Thunderbird now, so hopefully it will be in plain-text as
> > required.
> > 
> > > > ________________________________
> > > > From: Jared Holzman <jholzman@nvidia.com>
> > > > Sent: Monday, 31 March 2025 4:54 PM
> > > > To: linux-block@vger.kernel.org <linux-block@vger.kernel.org>
> > > > Cc: ming.lei@redhat.com <ming.lei@redhat.com>; Omri Mann <omri@nvidia.com>; Ofer Oshri <ofer@nvidia.com>; Omri Levi <omril@nvidia.com>; Jared Holzman <jholzman@nvidia.com>
> > > > Subject: [PATCH] ublk: Add UBLK_U_CMD_SET_SIZE
> > > > 
> > > > From: Omri Mann <omri@nvidia.com>
> > > > 
> > > > Currently ublk only allows the size of the ublkb block device to be
> > > > set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
> > > > 
> > > > This does not provide support for extendable user-space block devices
> > > > without having to stop and restart the underlying ublkb block device
> > > > causing IO interruption.
> > > The requirement is reasonable.
> > > 
> > > > This patch adds a new ublk command UBLK_U_CMD_SET_SIZE to allow the
> > > > ublk block device to be resized on-the-fly.
> > > Looks CMD_SET_SIZE is not generic enough, maybe UBLK_CMD_UPDATE_PARAMS
> > > can be added for support any parameter update by allowing to do it
> > > when device is in LIVE state.
> > 
> > That's fine, but we'd rather not take on the burden of verifying all of
> > ublk_params to see which ones can be safely changed on-the-fly.
> > 
> > Would it be reasonable to have UBLK_CMD_UPDATE_PARAMS accept a different
> > struct "ublk_param_update" which contains only the parameters that can be
> > updated in the LIVE state and will include only max_sectors for now?
> > 
> > Alternatively if you know off the top of your head which parameters can be
> > easily changed on-the-fly and we will add only those.
>  
> Fair enough, updating 'dev_sectors' should be generic enough, and it looks
> fine to add UBLK_U_CMD_SET_SIZE.

Also UBLK_U_CMD_SET_SIZE may be renamed as UBLK_U_CMD_UPDATE_SIZE.


Thanks,
Ming

