Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FCC41A91E
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962330; cv=none; b=QDkvYsbhGzGjSobz4MUJ3PGouE5Lvm0FQ7znDkj3vPrplLMLTYeeq81UdyisvD5Ei3rCduG6NjPb9f4I93YKFj5qICvY2CEAPT9dFr3sL/X3wLMXeeCUMW+gHkwZBJlxQwLeDg6pJq4Sgj1GiWs+dG6T6t7UfxvFYQPRLa10aV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962330; c=relaxed/simple;
	bh=eAQNAfuKGfSEMrVOhnpNQ3PiE3c8p6iAqxpfyUaYd4Q=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=SzzRu26rpAk9v43sN8GxdAeopa5FDtQVBjKFVH75tOYnT4onRIP70KG/WGadkoOuA3k/ey94lEnxfSTezUSzJvrc6nt0Qs/KxG9kOq0hVsslrefZSmQCRrkzBqz5l4nJP8gP/otqVjkbxidvRkisnFaOT+yxYSDoFf9YHYyJzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I0UQzVQZ; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I0UQzVQZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1791962328; x=1823498328;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=eAQNAfuKGfSEMrVOhnpNQ3PiE3c8p6iAqxpfyUaYd4Q=;
  b=I0UQzVQZeGmxch5KLcLtUlrpCRY/Yd3PlmyvqZy7xgQs3LC8VoUR2a7E
   Bi/tNVd6uFUXzsIdHMQBerGmEYyW5sdf5vVnyN63f+AUI08J4OwxzVnAF
   pQOX11h2yXWLRAP3h+nCxDFPIHhWDUdbY8Sv4G6TYdozPPhLJJ5hBwnIG
   1ErGeK2igoN74X/PVVd3jSXNAlbZo8nTMwpPf7Ie8N0Yv2g4lU/Y8aesO
   91xVybVRBIgcs0p5MFb9Z6s4bq8dKfiNOV49OjjC8oU2WpJaKXfpuRgXN
   3DwD1qguTMi958a67v5KnRfswZyP/+px2ItwuG11VlSRZdt8c+mIehEC5
   g==;
X-CSE-ConnectionGUID: vxxkxbDvT/OxZXec12gf0Q==
X-CSE-MsgGUID: iNhPKp22RFC99+txEhOY+w==
X-IronPort-AV: E=Sophos;i="6.27,157,1786982400"; 
   d="scan'208";a="158058761"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2026 15:18:42 +0800
X-CSE-ConnectionGUID: neAFQAzfQ8m2TmNBLrLA5g==
X-CSE-MsgGUID: Bkp5yqjBS+Wggm9QuyffhA==
IronPort-SDR: 6acf2cd2_cSPQqor3h0xp58SvULnB8/HZ8d11OrKFMW8e//m0gsuISyV
 S/aOqHnXOOGx7Ri7Ov2Ar82XmlBwqKUie4p6KEQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2026 00:18:42 -0700
X-CSE-ConnectionGUID: 6zAaSiOgRZqbryCnENSVWg==
X-CSE-MsgGUID: f60O1g77SeumJpHJSVN/0A==
Date: 14 Oct 2026 00:18:42 -0700
WDCIronportException: Internal
Received: from unknown (HELO kpd-linux-block-557bf6c7f7-td27w) ([10.149.64.6])
  by uls-op-esai1-o.wdc.com with ESMTP; 14 Oct 2026 00:18:42 -0700
Content-Type: multipart/mixed; boundary="===============6255565997434638926=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2c91db255fa527e76f5aa74f020d439a33e89142dc397211579876d34b3db51d@mailrelay.wdc.com>
In-Reply-To: <20261014053337.2328544-1-dlemoal@kernel.org>
References: <20261014053337.2328544-1-dlemoal@kernel.org>
Subject: Re: [PATCH v7 00/10] Add support for storage element depopulation
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org

--===============6255565997434638926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       [v7,00/10] Add support for storage element depopulation
Patchwork:  https://patchwork.kernel.org/series/1185265/&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/38517856454


Failed test cases: loop/006



--===============6255565997434638926==--
