Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE68C433EF
	for <linux-block@archiver.kernel.org>; Sat,  5 Feb 2022 09:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiBEJMC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Feb 2022 04:12:02 -0500
Received: from mail-sn1anam02on2085.outbound.protection.outlook.com ([40.107.96.85]:11693
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236403AbiBEJMB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Feb 2022 04:12:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/XAY9TZMu80k12nwn5np5nYDFWQvXrKvT6aeK+GvR9YG6AK925GvZhc3eMNRy/19IZQK/oIqolXSMSo/LR6y3mo6H54SS4TuvNvkIgV+4vnQYDmePN+7zYF+aMtsTbRIaCbki7XIyfQgbjEPYfbq804AZiZMCMeaB270xb320W9zoQUChDz7dvqLTqO5mv1ww5orm1lbRpvrYDfMh6bNLeW32XKIluOQiTeqlp937o0XB+4z6bgpU2xMbLGrQ9GxkSRsjYSb3duhFvDAoUmSTCajbxm6/Fefg3M5xQgtctNajhAgmQ7YMO6wIs5Gf6z37ZQZWKy3CMjS3N1UKh20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wakE+xTX/iQFkaENoSOZcy02GCferezyfaVU7PmsfM=;
 b=d44tJtdQBVrUrAb+pO29mlw0nDdXvlJ3HNx7aB9beUsq9+6n4xI/hBkD/uX+AXNAPamd7BJFyMoCWjGechqR2WGDP3Y8GNSl137jnmxr9oVPupqDVBJSBSi9DQBMufo1FL/4/uHwsBiNO0VcuVxcLRGt1rcsZ4V/qgKXyNEcAE2DBK9TTZSpSlnliZ8MnAO8xPVfE3XHxWzYJe4diCXvr3w6B8oRfMnx3z5zBeJudkqDDBQfjZEERQfkl5tkRkIFzx1r/eUM7QhS2PXEu2VRvAr3dnLn/1vtg4PMG4x1BmEzC8r2cYZIQqWgw3fIvwOGpYEpkUyGf1cjh9qnWbwAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wakE+xTX/iQFkaENoSOZcy02GCferezyfaVU7PmsfM=;
 b=McTcbX4RtPGOViadYhHDd/nWtfK8lEG7ZpP2Eu8wxCEJyc+QH6eOCgjLgjsrw8mZlkdg+pp50cH836KY3YErhtC/1KSnn6NlKngL92lj14hIgE8T+3LqBlMye+Hp/qm20eKNVa57C3KFUJ0TcqP/egimTF47qU6wCCZSvjnrTvAu0LlY6a3jJQX2nKWZb89HDe9Do8LK2IpEMo/3Z2//vXePDGgtitLpOniR9AvqAG+dwFQsW5iu71viHrtC358o3ZEVPJxZAULedHiuq6OSFR7lJTGh09YT58bJtRxXBFGuARg7vuWogPYuzPbM4hX3HCvZbvOYMUkSWXE1nz5Ofg==
Received: from DM6PR06CA0031.namprd06.prod.outlook.com (2603:10b6:5:120::44)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 09:11:59 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::69) by DM6PR06CA0031.outlook.office365.com
 (2603:10b6:5:120::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Sat, 5 Feb 2022 09:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 09:11:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 5 Feb
 2022 09:11:58 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sat, 5 Feb 2022
 01:11:57 -0800
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <shy828301@gmail.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V7 0/2] block: introduce block_rq_error tracepoint
Date:   Sat, 5 Feb 2022 01:11:48 -0800
Message-ID: <20220205091150.6105-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 417a867a-13a6-44fc-2064-08d9e88790c3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5357392A471D7B14B8D3A6F3A32A9@DM4PR12MB5357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3FyWUjPL34fywtBz4oySPdyV4KOXRVQUHQXPbPULHYISiidbRxeCenEUOV1UQEpTbrAEx8iockZPaQBif3tSwvSVKmVZUXAzxDkw97Pe1RHtRqBJH/pzw6P27r7aoFEFOQzyJTX2aphhVFbGM2Oeueaw3M5G/HI+Ap7UoqiP+bne4t21SYE3jV7Ivl3tOJ6vKFhBwb5IThjnuGNY6CJ0pzyZ/5UwM2rkn3p2VsvFx6ai7iNXD+LnVFGmDWew+Bj1FxkdVPgz/uv1OmbGCO32X1hC9FCcybC9zIUC6R9/U/mYOD1mTFq0SHL80jHYFNv+//mWQUHG7iZUw2DKzcghdsz1ZF9TRth/Vk1jydi1dmNe0lKITc9adaCelSiCBWveQuBZS9E7urKuFaIXpXvgXL1HvoH74DBzA6Pd5IR63Me9YUWSlDoBXDsD7asytRVDDoTnloZy5OEufaKPlP0sJjPLyaV645COMoxGj1NQbvotaKUJRXyCawFwvjaTC2ML4ySn4LVMI1F1k+s39KbfGvWfwz+U0kEcMaDx5o5dRcGPgpT6bELbVkwNhZqVx55EHEpORka7okLOuR7Z4EnasulYjzLDsL9anrF1qMcR22l2kgfNTOfqYKm2J7pJowGv2unRZWqjbgTO2Kw68glaVH8Rx2QhDn4z1t7AiZQnbMg/wPMqk1XPdvUnecH7CT9G0M0lB4tJkGE42tv6+vUcZdDVUaZNzdLwhHa1B9KVZziZIjh3AyfzwLIQ20ezbarzMvKYYn8y81BO154g4OYjd2zmTkM4ntCI8kFcmJ0uEA=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(81166007)(426003)(966005)(508600001)(316002)(5660300002)(54906003)(82310400004)(26005)(186003)(356005)(16526019)(1076003)(6916009)(36756003)(7696005)(70586007)(8936002)(47076005)(6666004)(40460700003)(2906002)(83380400001)(70206006)(107886003)(36860700001)(86362001)(2616005)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 09:11:59.5478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 417a867a-13a6-44fc-2064-08d9e88790c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Hi Yang,

I spent sometime generating V7 and testing the same. I kept your
original authorship for the 2nd patch and added a prep patch.
Let me know if you find anything wrong with this series.

Following is the cover-letter for everyone else:-

Currently, rasdaemon uses existing tracepoint block_rq_complete
and filters out non-error cases in order to capture block disk errors.
The generic tracepoint brings overhead see below and requires filtering
for the requests which are failed due to error :-

block_rq_complete() tracepint enabled fio randread :-

  read: IOPS=107k, BW=418MiB/s (439MB/s)(24.5GiB/60001msec)
  read: IOPS=107k, BW=419MiB/s (439MB/s)(24.5GiB/60001msec)
  read: IOPS=106k, BW=416MiB/s (436MB/s)(24.4GiB/60001msec)
  read: IOPS=107k, BW=417MiB/s (437MB/s)(24.4GiB/60001msec)
  read: IOPS=107k, BW=418MiB/s (438MB/s)(24.5GiB/60001msec)
  read: IOPS=106k, BW=414MiB/s (434MB/s)(24.3GiB/60001msec)
  read: IOPS=107k, BW=418MiB/s (438MB/s)(24.5GiB/60001msec)
  read: IOPS=106k, BW=413MiB/s (434MB/s)(24.2GiB/60001msec)
  read: IOPS=106k, BW=414MiB/s (434MB/s)(24.2GiB/60001msec)
  read: IOPS=109k, BW=425MiB/s (445MB/s)(24.9GiB/60001msec)
  AVG = 417 MiB/s

block_rq_complete() tracepint disabled fio randread :-
  read: IOPS=110k, BW=428MiB/s (449MB/s)(25.1GiB/60001msec)
  read: IOPS=107k, BW=418MiB/s (438MB/s)(24.5GiB/60001msec)
  read: IOPS=108k, BW=421MiB/s (442MB/s)(24.7GiB/60001msec)
  read: IOPS=107k, BW=419MiB/s (439MB/s)(24.5GiB/60001msec)
  read: IOPS=108k, BW=422MiB/s (442MB/s)(24.7GiB/60001msec)
  read: IOPS=108k, BW=422MiB/s (443MB/s)(24.7GiB/60001msec)
  read: IOPS=108k, BW=422MiB/s (442MB/s)(24.7GiB/60001msec)
  read: IOPS=108k, BW=422MiB/s (443MB/s)(24.8GiB/60001msec)
  read: IOPS=108k, BW=421MiB/s (442MB/s)(24.7GiB/60001msec)
  read: IOPS=108k, BW=423MiB/s (443MB/s)(24.8GiB/60001msec)
  AVG = 421 MiB/s

Introduce a new tracepoint block_rq_error() just for the error case to
reduce the overhead of generic block_rq_complete() tracepoint to only
trace requests with errors.

Below is the detailed log of testing block_rq_complete() and
block_rq_error() tracepoints.

-ck

The v3 patch was submitted in Feb 2020, and Steven reviewed the patch, but
it was not merged to upstream. See
https://lore.kernel.org/lkml/20200203053650.8923-1-xiyou.wangcong@gmail.com/.

The problems fixed by that patch still exist and we do need it to make
disk error handling in rasdaemon easier. So this resurrected it and
continued the version number.

V6 --> V7:
 * Declare new trace event block_rq_completion and use it with
   bio_rq_complete and bio_rq_error() to avoid code repetation.
 * Add cover letter and document details.
 * Add performance numbers.

v5 --> v6:
 * Removed disk name per Christoph and Chaitanya
 * Kept errno since I didn't find any other block tracepoints print blk
   status code and userspace (i.e. rasdaemon) does expect errno.
v4 --> v5:
 * Report the actual block layer status code instead of the errno per
   Christoph Hellwig.
v3 --> v4:
 * Rebased to v5.17-rc1.
 * Collected reviewed-by tag from Steven.


Chaitanya Kulkarni (1):
  block: create event class for rq completion

Yang Shi (1):
  block: introduce block_rq_error tracepoint

 block/blk-mq.c               |  4 ++-
 include/trace/events/block.h | 49 ++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 14 deletions(-)



* Detailed test log for two tracepoints block_rq_complete() and
  block_rq_error():

* Modified null_blk to fail any incoming REQ_OP_WRITE for
   testing :-

root@dev linux-block (for-next) # git diff drivers/block/null_blk/main.c
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 13004beb48ca..0376d0f46fdf 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1414,6 +1414,9 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
                        return sts;
        }
 
+       if (op == REQ_OP_WRITE)
+               return BLK_STS_IOERR;
+
        if (op == REQ_OP_FLUSH) {
                cmd->error = errno_to_blk_status(null_handle_flush(nullb));
                goto out;
root@dev tracing # modprobe null_blk
root@dev tracing # ls -l /dev/nullb0 
brw-rw----. 1 root disk 251, 0 Feb  4 02:45 /dev/nullb0
root@dev tracing # # note the above major number

* Test both block_rq_complete() and block_rq_error() tracepoints :- 

+ cd tracing
+ modprobe -r null_blk
+ rm -fr /dev/nullb0
+ modprobe null_blk
+ sleep 1
+ set +x
###############################################################
# Disable block_rq_[complete|error] tracepoints
#
+ echo 0
+ echo 0
+ cat events/block/block_rq_complete/enable
0
+ cat events/block/block_rq_error/enable
0
+ set +x
###############################################################
# Enable block_rq_complete() tracepoint and generate write error
#
+ echo 1
+ cat events/block/block_rq_complete/enable
1
+ dd if=/dev/zero of=/dev/nullb0 bs=64k count=10 oflag=direct seek=1024
dd: error writing '/dev/nullb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 0.00268675 s, 0.0 kB/s
+ cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 1/1   #P:48
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    kworker/0:1H-1090    [000] .....   586.020342: block_rq_complete: 251,0 WS () 131072 + 128 [-5]
+ echo ''
+ set +x
###############################################################
# Enable block_rq_[complete|error]() tracepoint and 
# generate write error 
#
+ echo 1
+ cat events/block/block_rq_error/enable
1
+ dd if=/dev/zero of=/dev/nullb0 bs=64k count=10 oflag=direct seek=10240
dd: error writing '/dev/nullb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 0.0022944 s, 0.0 kB/s
+ cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 2/2   #P:48
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    kworker/0:1H-1090    [000] .....   586.064527: block_rq_complete: 251,0 WS () 1310720 + 128 [-5]
    kworker/0:1H-1090    [000] .....   586.066135: block_rq_error: 251,0 WS () 1310720 + 128 [-5]
+ echo ''
+ set +x
###############################################################
# Disable block_rq_complete() and keep block_rq_error()
# tracepoint enabled and generate write error 
#
+ echo 0
+ cat events/block/block_rq_complete/enable
0
+ dd if=/dev/zero of=/dev/nullb0 bs=64k count=10 oflag=direct seek=10240
dd: error writing '/dev/nullb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 0.00235022 s, 0.0 kB/s
+ cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 1/1   #P:48
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    kworker/0:1H-1090    [000] .....   586.110419: block_rq_error: 251,0 WS () 1310720 + 128 [-5]
+ echo ''
+ modprobe -r null_blk
+ set +x

-- 
2.29.0

