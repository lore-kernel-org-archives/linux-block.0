Received: from orion.seaquake.net (orion.seaquake.net [195.62.218.104])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EEF169AD2
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.62.218.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801923; cv=none; b=rrl72g31dgFbEir7Ar4VpxbXln5oByDzMhqe5BHOuWHp8M4Ow2t1silzfnxvrcR8XtDmBs7d2ICWjWNeOOehzrxPb29OcliOE+jrWBf2gdmSNrNtznrSLK8TlIeIwCY5Yd0OikfwjBvPX/HXf2+G1mF1jRuyiGAar4WEf8CFP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801923; c=relaxed/simple;
	bh=1WXIdiSdtXhXiDSHL4TBXB/TPg/sIOTVc0kPqf/L2yU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BKdJbf/CIQUDxVUY953XB4EnU369NRX6pQkHVoNaODjBcqUkVhiNDSk9lbwjxS7iB6eWbNmsh6gpfUL/oKq+BE1sQHb4CjjPMYMnyCMxGZc0GQaTmym0GumxEugqjkiQaBSLwLG5HPUy+r8vHLy6E/4GzeNAzRTKjYc/c6E5Ym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lantizia.me.uk; spf=pass smtp.mailfrom=lantizia.me.uk; dkim=pass (1024-bit key) header.d=seaquake.net header.i=@seaquake.net header.b=NXZWbXNF; arc=none smtp.client-ip=195.62.218.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lantizia.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lantizia.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seaquake.net header.i=@seaquake.net header.b="NXZWbXNF"
Received: from zeus.seaquake.net (zeus.seaquake.net [195.62.218.101])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by orion.seaquake.net (Postfix) with ESMTPS id C26FDE647E
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 09:31:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=seaquake.net; s=mail;
	t=1756801916; bh=1WXIdiSdtXhXiDSHL4TBXB/TPg/sIOTVc0kPqf/L2yU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding;
	b=NXZWbXNF4NfIPFrR38b8/ojRXUH/3/SRFxjLkDN3tCFkeWeCuWe7NrFyX+NM+41NN
	 LMC6OuoFIKmnKm/8yWU7duEIRxPeheysTEpyAAIGLOjQ75qtCspuOpzPDoKEZBIxLd
	 HzGpVXrxkmk4CRB5872efZV8OVELKT4AGCg+PHxI=
Received: from [192.168.8.111] (unknown [195.62.201.126])
	by zeus.seaquake.net (Postfix) with ESMTP id 7C37F21C116
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 09:31:56 +0100 (BST)
Message-ID: <39911684-d760-1caa-6554-599cde6a71b7@lantizia.me.uk>
Date: Tue, 2 Sep 2025 09:31:54 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: linux-block@vger.kernel.org
Content-Language: en-GB
From: Steven Maddox <s.maddox@lantizia.me.uk>
Subject: Use block device with LIO as target without preventing local access
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,	
	
I'm working with a little setup of 3 x Proxmox VE hosts (basically 
Debian acting as a hypervisor).  But some of these servers also have 
spare disks (not used by the OS) and so I've used mdadm to do RAID 6 
over them (presenting as /dev/md0).  I've then used targetcli to get LIO 
(in the kernel) to offer them up over iSCSI, so these can be seen by the 
other hosts.	
	
Due to how my /dev/md0 blocks will be directly used by LVM (i.e. 
pvcreate /dev/md0) and nothing more... and how Proxmox VE will keep 
track of which hosts should be accessing which LV (so there is no 
collisions)... there is no good reason why the host shouldn't be also 
allowed to continue to access /dev/md0 directly, as well as LIO offering 
up via iSCSI.	
	
Can anyone advise how I stop LIO from taking exclusive access of /dev/md0?	
	
I'd rather not have to have iSCSI connect to itself (i.e. 127.0.0.1) nor 
swap to a file-based block device.	
	
Thanks	
	
-- 
Steven Maddox
Lantizia
