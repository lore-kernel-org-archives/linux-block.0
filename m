Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C05226D18
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787074336; cv=none; b=LjBAeZnC8A2UOuGCtYqg4EnkUDvm4NBrQF4YdzaDPL17ZypcW6wqu9HycucD1nToo7vyUdzfHNRmrlseboP4FZJ06TyO0m8hrvvh4lEBH2qxVmMoahlD5Zly5CRDncokP+I/xzYtfwB0t9qpnM+5tNFbQJiSClC917MW1nrsYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787074336; c=relaxed/simple;
	bh=4X3X595DlJ3Fl46k1OE/Cu89WR2kbDCEKULaEFnTVKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcpmTaBBG0eceyp7dnTLERZypUlMx8EgSU7Ml11QPs6Ajt6Kzm73d7kZpAMQcPTY0+stRh0sf1KPrpaK5QrNILwjzlOlUMcSpn77EYEfWNDF73UsZJee6eTNpCm5IoOLET09z4peZnRkLa3uGYbTZN33tbUQb1/4Nypjx3/dv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXvhhSAl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXvhhSAl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787074333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsigVlxc1Yx5xrsa1S52pC/wAn87RkEo7OEJR846FGI=;
	b=gXvhhSAlLhNQpYBlE7mGTUpS6NFEdIzUFe9NGCOThnPfJjo5SPrEQxkc48DY0FK0K4ijBH
	G7tryQGx3YXiNGpLW7ctWnFskkU7Hds5Pt6wVXYHoJiu6MPa7HAEFe3eFBaDMTdeea1/OU
	AaonNZQf3ttvZZD74z5BzgZJTCkLf8Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-Vk-8hWHsO6qKZAjiypooVQ-1; Tue,
 18 Aug 2026 13:32:12 -0400
X-MC-Unique: Vk-8hWHsO6qKZAjiypooVQ-1
X-Mimecast-MFC-AGG-ID: Vk-8hWHsO6qKZAjiypooVQ_1787074331
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C7BE1800869;
	Tue, 18 Aug 2026 17:32:10 +0000 (UTC)
Received: from [10.17.17.225] (unknown [10.17.17.225])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AF383000239;
	Tue, 18 Aug 2026 17:32:09 +0000 (UTC)
Message-ID: <3e9c2a03-9a8f-4e20-9c7d-1b55edc58a9d@redhat.com>
Date: Tue, 18 Aug 2026 13:32:08 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/2] Test multipath and marginal ports
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Daniel Wagner <dwagner@suse.de>
References: <20260812174503.3705830-1-jtaubepe@redhat.com>
 <an75bRJc8J6NexeH@shinmob>
 <CADRr4beUeZo9ZA9TZVmWQ9Vegm2LvTXkW0wGNxYA6_7z_njMEA@mail.gmail.com>
 <aoK5sfNpxIUz7C02@shinhome>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <aoK5sfNpxIUz7C02@shinhome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/17/26 03:38, Shin'ichiro Kawasaki wrote:
> Yes, it happnes always I run the test case. After I rebased to v7.2 kernel, it
> shows a bit different message:
> 
> nvme/070 (tr=fc) (test nvme-fc marginal path handling)       [failed]
>      runtime  37.200s  ...  38.926s
>      --- tests/nvme/070.out      2026-08-17 11:13:53.073000000 +0900
>      +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad       2026-08-17 16:34:17.997000000 +0900
>      @@ -3,10 +3,14 @@
>       Testing iopolicy: numa
>       Changing FC links to online
>       Set all online: pass
>      -One host marginal: pass
>      +FC port on (/sys/class/nvme-subsystem/nvme-subsys6/nvme6) is being used, expected no use.
>      +One host marginal: fail
>       All marginal: pass
>      ...
>      (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)


I'm seeing this same issue on my QEMU based test bed.  This is a timing problem and the issue does not appear on a high CPU count system.

Jesse and I will work on a fix and update the patch series.

/John

