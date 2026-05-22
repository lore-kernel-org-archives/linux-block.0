Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6533438A2
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435876; cv=none; b=sk929W18pqL+LFbeGw9jo2ngkUDouZvQHMzojppFCiqi9HsKbVIRlw65ZubqjWBxWHGV2I56Q7JqOx2KzM2nCcK6zDmafjXi99Z3Haw04Q1AYUl9fTwcwk8Z3HuUywd+yUGno9KTyhgXnE9nEaU3ma0uG8WfGSMPITFwsSs4RzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435876; c=relaxed/simple;
	bh=z9FVaWRE1Qlve229JPlj471trqesaKhT20bEZdAo41U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLZf/AMsWaX+JTDsAO5cvPYYgu2x/qAwFYXScI2hNvHAn2qWGEs07bGCh+C17EW0XsZsJ/VF7RstPUKhQhfm4pLCMCGfKGUbQjxcG9v9Y0SdMeBSKMBU0FPrxIhymTaNWWW3l21ZiuC4jPiY4fLW981+mdT84pvjjDwy0jbyQmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SsbnheLg; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SsbnheLg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1779435874; x=1810971874;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z9FVaWRE1Qlve229JPlj471trqesaKhT20bEZdAo41U=;
  b=SsbnheLgtV5k2DxOonm2AlXbwE3i2m1SAPc+2jpRk5D7QzvgCMQWKKqA
   wgkQdAz5MVx3NHAlCWP+lBOYAploeOoqndXvEeKPGd+PeaN31P39BLvMa
   FL/rrHu9XFV+IAbrmLf3FJyXiLTiPT1aeuPoJ6PA/0N+Syia47jDYJv9S
   oQ5yKMkvlVmyHsga7uSU0SsBx9PdsN1ECQ/IS/Kn6o7P1n9vCk7Eopfy1
   CexfUBx4jEbjvjaWMIKV55Kdd7+Myhs/zNidh/wXzPlSizF9WAcvvXpnN
   RSG4I7IxOAfbl48PL3J4GZIyPArCfKZJRNzboqZHRz1/l2V8G1tZeonLy
   w==;
X-CSE-ConnectionGUID: briB7HvKTWCLIdYIhCNNPg==
X-CSE-MsgGUID: WkxX8AbySNWv0bLg8brBCA==
X-IronPort-AV: E=Sophos;i="6.24,161,1774281600"; 
   d="scan'208";a="148290453"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2026 15:44:28 +0800
X-CSE-ConnectionGUID: cfjQjijNTp2Prnk6qF9nFg==
X-CSE-MsgGUID: JKgROzarSF+c08UTguUoDw==
IronPort-SDR: 6a100934_gGrMzT6DUIb6Ksh0ALDEMhh6kKi+4bVBPe2iAdt8340T5a2
 rwKPTXu+q08eFXXVJtWUak+0tM5ZVN6ff41BDMg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2026 00:43:47 -0700
X-CSE-ConnectionGUID: tFkeOL2UQWWG9CDm+CTUTg==
X-CSE-MsgGUID: wyPqq7QVRymV1X/qy3mQCg==
WDCIronportException: Internal
Received: from wdap-hzhmxgfxvd.ad.shared (HELO shinmob.wdc.com) ([10.224.105.12])
  by uls-op-esai1-o.wdc.com with ESMTP; 22 May 2026 00:43:46 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Ted Ts'o <tytso@mit.edu>,
	dennis.maisenbacher@wdc.com,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests RFC 0/2] add JSON format reporting
Date: Fri, 22 May 2026 16:43:43 +0900
Message-ID: <20260522074345.227515-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During discussions at LSFMMBPF 2026, I learned that there is interest in
machine-readable result reporting for blktests. Ted described how the
machine-readable reporting will be used in this post [1].

[1] https://lore.kernel.org/linux-block/20260511154046.GA21199@macsyma-wired.lan/

This series is an initial attempt to add this feature to blktests. There
are two possible reporting formats: JUnit XML (used by fstests) and JSON.
JSON appears to be more widely used, so this series implements reporting
in JSON format.

The first patch adds the option for JSON format reporting. The report
includes the results of each test case. The second patch adds summary
statistics to the report: counts of passed, failed, and not_run test
cases.

An example command line to use this feature is shown below [2]. The
--json option specifies the JSON file for output. Results for each test
case are reported with the "status" field.

Comments and feedback are welcome as always.

Ted, please review the JSON output to see if it meets your needs when you
have time.

[2] command line example

# ./check --json /tmp/loop.json loop
loop/001 (scan loop device partitions)                       [passed]
    runtime  1.411s  ...  0.820s
loop/002 (try various loop device block sizes)               [passed]
    runtime  0.953s  ...  0.494s
loop/003 (time opening and closing an unbound loop device)   [passed]
    runtime  1.245s  ...  0.685s
loop/004 (combine loop direct I/O mode and a custom block size) [passed]
    runtime  1.624s  ...  1.611s
loop/005 (call LOOP_GET_STATUS{,64} with a NULL arg)         [passed]
    runtime  0.137s  ...  0.065s
loop/006 (change loop backing file while creating/removing another loop device) [passed]
    runtime  31.287s  ...  31.201s
loop/007 (update loop device capacity with filesystem)       [passed]
    runtime  0.532s  ...  0.489s
loop/008 (setup GPT and ESP on a raw disk image)             [passed]
    runtime  0.813s  ...  0.848s
loop/009 (check that LOOP_CONFIGURE sends uevents for partitions) [passed]
    runtime  1.551s  ...  1.407s
loop/010 (check stale loop partition)                        [passed]
    runtime  98.465s  ...  98.253s
loop/011 (Make sure unsupported backing file fallocate does not fill dmesg with errors) [passed]
    runtime  0.395s  ...  0.434s
loop/012 (check for spurious partition removal when partscan is enabled) [passed]
    runtime  6.216s  ...  6.012s
# head -20 /tmp/loop.json
{
  "results": [
    {
      "name": "loop/001",
      "status": "pass",
      "description": "scan loop device partitions",
      "runtime": "0.820s",
      "exit_status": 0
    },
    {
      "name": "loop/002",
      "status": "pass",
      "description": "try various loop device block sizes",
      "runtime": "0.494s",
      "exit_status": 0
    },
    {
      "name": "loop/003",
      "status": "pass",
      "description": "time opening and closing an unbound loop device",
# tail -20 /tmp/loop.json
      "description": "Make sure unsupported backing file fallocate does not fill dmesg with errors",
      "runtime": "0.434s",
      "exit_status": 0
    },
    {
      "name": "loop/012",
      "status": "pass",
      "description": "check for spurious partition removal when partscan is enabled",
      "runtime": "6.012s",
      "exit_status": 0
    }
  ],
  "summary": {
            "total": 12,
            "passed": 12,
            "failed": 0,
            "not run": 0,
            "time": "142.319s"
          }
}


Shin'ichiro Kawasaki (2):
  check: add JSON format output option for test results
  check: add summary statistics to JSON report and --stats option

 check | 297 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 296 insertions(+), 1 deletion(-)

-- 
2.54.0

