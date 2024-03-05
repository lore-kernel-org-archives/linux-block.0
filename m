Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E4A4CB58;
	Tue,  5 Mar 2024 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628747; cv=none; b=cm4d1Wh0xULq0PmWG21M1er0i65237+UY0TL42R6bxcKQIrHZ03ZcUOKxNopAoC7uezSq8ldVpVt86xscM76UvGZ4FQWdOlG/4P5mEXEhHTNkSE+nZv80ERpHxYAu8cNgfCBz1WnACaD6S3QvwlWItLXVKQmZW0fXuVkgbSphdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628747; c=relaxed/simple;
	bh=fQfjSN3GrHCr7EmgsLNb1WTj1bVNcHKeybvX8+51GkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCTh//C3laYrxl7oWosl0O64sVcChum9KBDAwllVpcaEanDKjCisUDH0dSvVuXU9EE+3kj81DzdTntMg3OvvvFwo3zlkWnKw81zJ5WOODPkhAsxnjYYjSFKUb7GhTml4gHrKeEDhyWmNraimKKHvvGV3kcGj/1oIHoIQLvW0j/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=vP5fwqOa; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="vP5fwqOa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=fQfjSN3GrHCr
	7EmgsLNb1WTj1bVNcHKeybvX8+51GkY=; h=in-reply-to:from:references:cc:to:
	subject:date; d=aixigo.com; b=vP5fwqOaBDQQtkt7usW5j5roTVsB1yk7NqaEV7wT
	8mfh948ibXZvsduo6rn1zEyz7AvnMtsEgBAe4t6OY7Dmq4hZOE9xcWCirvb2alSlVxAaGL
	D9hBBakNI+oeJd+rRJn2sonqBxZKXANROdJSzb8oA2FcTPHfVqe2acQHOIk7o=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 12e58b84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Mar 2024 09:52:13 +0100 (CET)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 4258qCWP1098777
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Tue, 5 Mar 2024 09:52:12 +0100
Message-ID: <7f2bffbd-8ba4-4629-a318-5af95133c002@aixigo.com>
Date: Tue, 5 Mar 2024 09:52:12 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: RIP on discard, JMicron USB adaptor
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-usb@vger.kernel.org,
        Harald Dunkel <harri@afaics.de>
References: <70bc51d7-c8a2-4b06-ab7a-e321d20db49a@aixigo.com>
 <62296d89-f7e6-4f54-add8-35b531dc657c@rowland.harvard.edu>
 <Zd9Xbz3L6JEvBHHT@kbusch-mbp> <yq1sf1c1h0x.fsf@ca-mkp.ca.oracle.com>
 <7a10ff3b-0c4c-4aa3-8218-02d5f27ab062@afaics.de>
 <029ff780-902e-42da-a5ed-6c306c6cb2e4@aixigo.com>
 <yq14jdlv3cv.fsf@ca-mkp.ca.oracle.com>
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
In-Reply-To: <yq14jdlv3cv.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

On 2024-03-05 03:14:24, Martin K. Petersen wrote:
> 
> Well, the device reports that block provisioning is disabled (lbpme=0)
> which explains why discard is not enabled by default.
> 
> Oddly enough your device does not report an UNMAP granularity. I'm
> trying to figure out how your discard granularity ends up being 0 given
> that your device reports a physical block size of 4096.
> 

I have inserted 2 other m.2 SSDs into the adapter: There was no problem
with these, esp there was no warning about discard_granularity, or a RIP.
First SSD back in: RIP is back, too. I would guess the first SSD is bad.

Sorry for all the trouble. I should have tried another m.2 SSD first.

Just for the record, this is what smartctl -x reports about the bad SSD:

-------------------------------------------------------------------------------
root@dpcl082:~# smartctl -x /dev/sdf
smartctl 7.4 2023-08-01 r5530 [x86_64-linux-6.7.6-raw] (local build)
Copyright (C) 2002-23, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Number:                       SAMSUNG MZVLB1T0HALR-000L7
Serial Number:                      S3TPNX0K917992
Firmware Version:                   5L2QEXA7
PCI Vendor/Subsystem ID:            0x144d
IEEE OUI Identifier:                0x002538
Total NVM Capacity:                 1,024,209,543,168 [1.02 TB]
Unallocated NVM Capacity:           0
Controller ID:                      4
NVMe Version:                       1.2
Number of Namespaces:               1
Namespace 1 Size/Capacity:          1,024,209,543,168 [1.02 TB]
Namespace 1 Utilization:            1,015,982,354,432 [1.01 TB]
Namespace 1 Formatted LBA Size:     512
Namespace 1 IEEE EUI-64:            002538 8981be5959
Local Time is:                      Tue Mar  5 08:29:01 2024 CET
Firmware Updates (0x16):            3 Slots, no Reset required
Optional Admin Commands (0x0017):   Security Format Frmw_DL Self_Test
Optional NVM Commands (0x001f):     Comp Wr_Unc DS_Mngmt Wr_Zero Sav/Sel_Feat
Log Page Attributes (0x03):         S/H_per_NS Cmd_Eff_Lg
Maximum Data Transfer Size:         512 Pages
Warning  Comp. Temp. Threshold:     81 Celsius
Critical Comp. Temp. Threshold:     82 Celsius

Supported Power States
St Op     Max   Active     Idle   RL RT WL WT  Ent_Lat  Ex_Lat
  0 +     7.02W       -        -    0  0  0  0        0       0
  1 +     6.30W       -        -    1  1  1  1        0       0
  2 +     3.50W       -        -    2  2  2  2        0       0
  3 -   0.0760W       -        -    3  3  3  3      210    1200
  4 -   0.0050W       -        -    4  4  4  4     2000    8000

Supported LBA Sizes (NSID 0x1)
Id Fmt  Data  Metadt  Rel_Perf
  0 +     512       0         0

=== START OF SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

SMART/Health Information (NVMe Log 0x02)
Critical Warning:                   0x00
Temperature:                        24 Celsius
Available Spare:                    100%
Available Spare Threshold:          10%
Percentage Used:                    4%
Data Units Read:                    32,373,823 [16.5 TB]
Data Units Written:                 59,721,865 [30.5 TB]
Host Read Commands:                 848,557,454
Host Write Commands:                1,025,191,828
Controller Busy Time:               2,700
Power Cycles:                       2,222
Power On Hours:                     5,568
Unsafe Shutdowns:                   666
Media and Data Integrity Errors:    0
Error Information Log Entries:      3,607
Warning  Comp. Temperature Time:    0
Critical Comp. Temperature Time:    0
Temperature Sensor 1:               24 Celsius
Temperature Sensor 2:               25 Celsius

Error Information (NVMe Log 0x01, 16 of 64 entries)
No Errors Logged

Self-test Log (NVMe Log 0x06)
Self-test status: No self-test in progress
No Self-tests Logged
-------------------------------------------------------------------------------

Regards
Harri
