Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057D339B44
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052684; cv=fail; b=LUa7LBhObu8IGjJFg4J1bXroTNK2f3ODh7hBWpbWu/PLRvg0RJ9Zu3xuTSxilD5YckSwd2+T7CaoHtsI8NHnuw9h8xDBe7ryn3E8A+n+W6zZbKKx7KKLTuZ/chQpZAN7aUQNUlTVekE+XljtLq8fyqWm/l4yjDwNRs7vabHr8Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052684; c=relaxed/simple;
	bh=ApmKFO7ZtrGPkwAg2UEsZ6JwAtvXNcyL6WswRxHsJ7A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I3/MpyZJnbeLmqozUKTOfgY7q6p+X5/RSmyjc+EWd0tOTfeKrX2+puektcun2uD6zQIxUV4YbwfCNcmXh1jpJGv4saVkZubxe5UT2+GBTdKHVKU94ZcGrfJ5Dy0Ir58XkekCKujmeFzja9j9EB6GkjsL1HKGevzz3L/OUrH67SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eR2ehx92; arc=fail smtp.client-ip=40.93.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eR2ehx92"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Idz5yNk5Cdxn8AuewVannpWoWQpawszOVVu/F1hYNbKpoXV4LA8rOgBzhOa9DYQQtxgNR5oP7SmfZNXmZ/NMJ546tPO2NJfC96s3Ga1qqriR6cODQ43Z0ZZjOyQcbz3oAGHS/d4MxjSdnjbatc/zO3jmXdSc0RT1Esn+MoXSJOSArVHg+HSy1yxvmkCnapyxbZglLGKIb5IaccPetQM8ICyPr+Q6pmzcBvj5QVrj/SsLfAp1zRDC64GQLIZRbwHLoLIWn7fXIwpHdGDBDmtlZuQFs/fHhmFZ6pmoxUXqtRvf2PRZ9RJmxxR7QdCKT5vgyFu1pgy2CsW26qVhR1zPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApmKFO7ZtrGPkwAg2UEsZ6JwAtvXNcyL6WswRxHsJ7A=;
 b=RO8+wgunKdO2D0gviFhvUyNo+0+4baQ1i+On+vJC/mWQq9nGUb3BZWqidvXnhILiYOKTJ+J6v8rKr78KrK+WTfwLp6MHwEQAetC8HpiVfv20I5Gaic/7tz7c/GsB485XyRRSZyMe6lOFDrpJr0XzWlqHTgOr1QcEr+iwaLXP1Bl2dJcRbyKSbT6K5zcAUbPcSg/VtUTQ1eonZ5TBriNdb/Sj7AbobCkGeTV9C7jH7tftIYFNbOcO2bItFxvYGJFfUBGFn5EtZQhgQOYBntl1cfsGu5Wz+3bmnwooaRHBZW7b0QCJjyL4oBGWVZ5winG+aUjDPKE1uB5R+KKiz1FQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApmKFO7ZtrGPkwAg2UEsZ6JwAtvXNcyL6WswRxHsJ7A=;
 b=eR2ehx92UBfYLDtXvzMwU9eMkfE1mUqtu02tU2O8IOlEsKYuVlfbIwB95umk/AQG5+UHA9ZArYNVFcPQ72N/7tobTGlzkd2t9neoBXQIxRlPFiu0pEznr6hezvo7NqyICQh0mmme8rGNeM5qUVpD+N6taQ4D0ljSV/WP+3+cBD8hL2VG6IY92LlO5FYYgG+qYU1yqNvlGBXzf+kcj8pD/2u8R7cWNMs217iXYNk7CVXOxtS4P8rpq5by9h03ZkkRFe3R/fctkgwGYKi1fucnoYwXrZyBmvcoMsXXIq3zXZvs7mEqPJVbp5qtSfOZ8R6X1Xa8yN7cZ9+OFrcA64wGfw==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 10:11:19 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 10:11:19 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Jared Holzman <jholzman@nvidia.com>, Guy Eisenberg
	<geisenberg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Ming Lei
	<ming.lei@redhat.com>, Ofer Oshri <ofer@nvidia.com>
Subject: ublk: partition scan during START_DEV can block userspace
Thread-Topic: ublk: partition scan during START_DEV can block userspace
Thread-Index: AQHccATY7WY9YL48CUGdcY6rcDZ6kg==
Date: Thu, 18 Dec 2025 10:11:18 +0000
Message-ID:
 <DM4PR12MB63280C5637917C071C2F0D65A9A8A@DM4PR12MB6328.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|IA1PR12MB6283:EE_
x-ms-office365-filtering-correlation-id: 1902db13-2ebe-4d24-e38b-08de3e1dc970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cwCxZOCJGJA2ANsTaiYj+kwPW9M9zhC4br4o3yAO7+VsaNIc5vSWhLgLSE?=
 =?iso-8859-1?Q?tzBue8k+dOaLmhJaR9PFztSrQ90/9yG5nkuJcLfjMWRThMVUpTa+6k1ecR?=
 =?iso-8859-1?Q?yDMgQ0LtV4cUpMIbTcSC6+YXcN6yJlqi1E5v3Kw3fEhI5Cpft1VnuuIYdu?=
 =?iso-8859-1?Q?keb4rqlwxFhFVrD7hY1xA1vq+cSKhIM10tXlHbt0HekCxGqN8q4OCTkTY4?=
 =?iso-8859-1?Q?lPagHGyZjAveyWKFcyBKBofh6JpOkARhGm4Vz1idw8TKYB36hj3sIkfuJG?=
 =?iso-8859-1?Q?ZDNhJYtEMFOmEZGGMch1jmTdz1Ek2BsOkvtgg8lGte0GaZGvwL5Hzeks0P?=
 =?iso-8859-1?Q?j4ZHFHGuiyJcRkuFaed+OjpQY/fxRp80Afz4drNTLLk9MUkv572re98ERd?=
 =?iso-8859-1?Q?dOuBGoUtal0HDVRPvvA6XzXmJjy20UyOW37+zYZQAizxm6G4YtD5//eZEv?=
 =?iso-8859-1?Q?B/fqC6JTyVgq+9qtBgWbkpxztyBFs7GolmEzOc5IBM3A3JLZUi+0Mkwqv+?=
 =?iso-8859-1?Q?xFwH9iTqMoVlo8FjBFtlBIRoJlfXRW8Wr/0St3bfPLFyOS2ocTOdqeAm2E?=
 =?iso-8859-1?Q?1jjICi59wXyhbaiLAiiuu3B+UFS1r+ac9AajF0+i22tKsRxdDCsrHIovUF?=
 =?iso-8859-1?Q?K1pnOyYZjyXqanP7SDBb7e2SBi5ES6aoi9Wo3lS9OVrEGSyXxSKira2UTF?=
 =?iso-8859-1?Q?30AAFr3MEu2NQOtgbf6boGIPsaY3lJoal1VQcjTvXttoe8ZWK6dJMJaa9e?=
 =?iso-8859-1?Q?+BZxYSH/kW/y6i8M+L0bkJN0QxS4EmJPQ+1Bcr3AQ2aAlsaPCtevo4Sx5t?=
 =?iso-8859-1?Q?ta6Tz/adDYRzddfHJEue7HWuZj1AmGvQLErnkA6gSSS848GIvGNOo6q/qb?=
 =?iso-8859-1?Q?RUunewAjcDKJzPiinql6fSOK72IMK0PQxkV/ERpC/BP4/CUfHoxnvaiAiv?=
 =?iso-8859-1?Q?LZzSw/wIgEKchSQozUqH/7B2cXPJGx/kMt+dh7KckyIYcQtjRN24FM5aZZ?=
 =?iso-8859-1?Q?bS/4lGhFavwahOdjbgSk1IeLulTtSBFrXMsBtp76d6rbqVp3KJZJ7hBhmJ?=
 =?iso-8859-1?Q?O/SPXDQvhSCTxvBr9LSoFXDj8VznsYO3GrmEiNFNs7YZoIO9yLhG+KsIJx?=
 =?iso-8859-1?Q?le8BnB+s12pl90XYyMzsskY6yOjmJBasfyQkR0+zH4E9LP6mSqiuz6uCCH?=
 =?iso-8859-1?Q?sT3HciG/uNaB94Xt1yqhsuNT5KgYqXFMaeKU0sSwgjm42ClBajidJPihKh?=
 =?iso-8859-1?Q?jJDH2XuzZH3h8Y0dcA4NMqjp45WviIzlMiBWniah64u9zJSOm/qKf4qny5?=
 =?iso-8859-1?Q?8V0l6Sxpnio4q0yo9xEN61GJFCLvO/1iDqrb7uViBBUG8lAjgTsT+DGCLz?=
 =?iso-8859-1?Q?POKzmIFMpMRo8nY8UZUge151q6ieSPLgGjxUPNsWO87kl8vRLjXrHNvoqG?=
 =?iso-8859-1?Q?vCN5UEABdCfMtzrCC65yq/SxfKtDIJ1tsO6Vbh7DmEWU2M9iV/MFcOaX56?=
 =?iso-8859-1?Q?p2VhcynrutT3L8/EGMhwukR23k8gD90RX2ufE1HKmRnSQmSirHTP33A6Va?=
 =?iso-8859-1?Q?Iys26jeMo1WDmTifZXp7wDzaa3Br?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KI5GrfwfsOOo16iBBXJw5rtQyWsiRt+wKiHHeJ/+MxAW+PebQAHcYu7jRl?=
 =?iso-8859-1?Q?zzWo/FpyLFZjcwLpQV5N4M8UzmFxXhSJC9lw3jdcZFTC4XNqg6kGo73vJh?=
 =?iso-8859-1?Q?LKoBKAV3otHShlUfLlfXE6YalT/40tG25H/OhtLKa1Hfa6dIhotyThFgKG?=
 =?iso-8859-1?Q?CRJ/8dCIWCQHv17EPgU83lvc2JesqObsy4ilIN23fNcJFZ4OCVGf0UWsLr?=
 =?iso-8859-1?Q?irmzo0pji8xRU4oqsO/qMeV+4M+rbApR0L0M7u9QMl7Jn3aWNDpiNVoAhz?=
 =?iso-8859-1?Q?IQ77l+bDOu8b8GZ+lqCdjMuVpKAqHaup/OtHy0Q+I9BQLh3P7Y7sZhqpih?=
 =?iso-8859-1?Q?3yRupQcQQ6RkRNrBdJ3nh0/uh7Y2/iy3dFkZ3m5KMKIp80m/bc5/5KYEBU?=
 =?iso-8859-1?Q?SZTcS5E6TTSt7XLb9AWuBoX6k+QyNeRjUkE+G8v98pOriszzoCNElPeBro?=
 =?iso-8859-1?Q?xpFLHapPmEsqG6NJSWomWTGgMNBz5ToNKI+0rLh507O50x76vdyhI3ygQr?=
 =?iso-8859-1?Q?zQPR1YAnY+EwyD/sUGM8z1Re3fF54FxVsP8rXNTKLyRNoEAqBSxaNvfTb4?=
 =?iso-8859-1?Q?s62irj5x/D51iELsXgwhD8XdpznYhA4/80PcVKCKXmrx0WsmfjTOkWgFS8?=
 =?iso-8859-1?Q?T7x8XGY69BqLr4vKM0ckGLZ03UCaLnJxRFQLf9CMnXBvjcT0fgZ9S8Ou5O?=
 =?iso-8859-1?Q?79WoOEsB4ZA9ByBPO+2+3MOMxEwSfwIoIdTLkQj6lWIdc3egPOW+CV3mLU?=
 =?iso-8859-1?Q?z1zWuCuj+ecyLksK9NEMeaY+GeMcnz5a/PyAyv5BKvf/a2vW4orrUvHO2V?=
 =?iso-8859-1?Q?hLzkdhZjI4TmK16rzgYtKfZ5ZZ56ZmY9O/tc5wehSHxKwpckK9Y7FXTm7W?=
 =?iso-8859-1?Q?Rpjv8hbpWNFghx7cL8Px0d/TJ/q/FfCDdJdy96UzBb5sAexLGq8WgCwhf2?=
 =?iso-8859-1?Q?1g499Tm26FbeWNtEHcIcSQIcSPKFdrnavTR3aaKJOOinQu9HN7bNQfySL/?=
 =?iso-8859-1?Q?1nLx7TTd8JYYdkXmtowvdsiq3un2rP3EaJRTb+DrX7sHTx/ZgvN1ScCDsg?=
 =?iso-8859-1?Q?et8tPGMlsIChyYIA3FUbFFmmWNVzGDZCgb7UsPmxV9C7qArliCsCoAvw91?=
 =?iso-8859-1?Q?dZifZ+JjJxFtO798oW0k+YpCvjyB1Kc6Py2SHJScuqqi/Gdn4b2ZRN6dM8?=
 =?iso-8859-1?Q?gLwl6srdnsXgg9/6BHi6/GDP0yj5hYWV5xsGhpmE4Xkf+JtTaSfZL5axc5?=
 =?iso-8859-1?Q?bqLOWrlUSlpstgXXwmxV1wVKdcbU8dOEuPZuz2CvtffwOv3OP/N7RorCds?=
 =?iso-8859-1?Q?OXLWvWvf+WmvoX8SE/QtABldzbgOMc476pa9D2f37iuFSxeOavsyOyn7il?=
 =?iso-8859-1?Q?B4ACnsJHvPJjSuMH8fWDP9MQidIxOebZ9hskHcASDF3Q1BxxQlMVALo34M?=
 =?iso-8859-1?Q?MziS9lLNKfnbyLiScE7SnvjW5CfOUR/JzkEZV7ftTbsR+ajy/FRQF2NevM?=
 =?iso-8859-1?Q?EyORAZDiLUuVKuS9fFPtfISVjfQvYnxZvnpryNrE5v8BB3/TG3lyQV1alw?=
 =?iso-8859-1?Q?wvxI3ZEBHZpD26fWGU9OpLoLOHHjzEQ3rU/0HHO77QxO1ZfgKoxRXN88Sc?=
 =?iso-8859-1?Q?BNJj+T01OjbRs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1902db13-2ebe-4d24-e38b-08de3e1dc970
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 10:11:18.5676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGWBs4L+U/Oz1i4vHniGa+YHR0HGzJaWoVOyfkbjzOTLLxttApy0od4fL1az8RBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283

Hi,=0A=
=0A=
Background:=0A=
We expose a network-managed block device using ublk.=0A=
=0A=
When issuing START_DEV, the kernel automatically attempts to scan the disk=
=0A=
partitions. This results in synchronous reads from the device, as shown in =
the=0A=
stack trace below:=0A=
=0A=
[<0>] folio_wait_bit_common+0x138/0x310=0A=
[<0>] filemap_read_folio+0x94/0xe0=0A=
[<0>] do_read_cache_folio+0x80/0x1c0=0A=
[<0>] read_cache_folio+0x12/0x30=0A=
[<0>] read_part_sector+0x39/0xe0=0A=
[<0>] read_lba+0x91/0x110=0A=
[<0>] find_valid_gpt.constprop.0+0xe5/0x5d0=0A=
[<0>] efi_partition+0x5b/0x360=0A=
[<0>] check_partition+0x166/0x3c0=0A=
[<0>] blk_add_partitions+0x3e/0x280=0A=
[<0>] bdev_disk_changed+0x149/0x1c0=0A=
[<0>] blkdev_get_whole+0x8c/0xb0=0A=
[<0>] bdev_open+0x2ea/0x3c0=0A=
[<0>] bdev_file_open_by_dev+0xde/0x140=0A=
[<0>] disk_scan_partitions+0x68/0x130=0A=
[<0>] add_disk_fwnode+0x46c/0x490=0A=
[<0>] device_add_disk+0x10/0x20=0A=
[<0>] ublk_ctrl_start_dev.isra.0+0x29d/0x3a0 [ublk_drv]=0A=
[<0>] ublk_ctrl_uring_cmd+0x407/0x600 [ublk_drv]=0A=
[<0>] io_uring_cmd+0xa4/0x150=0A=
=0A=
Problems observed=0A=
=0A=
Userspace crash can leave the process stuck=0A=
=0A=
If the ublk userspace server crashes while this partition-scan I/O is in=0A=
progress, the process may fail to terminate cleanly. For example:=0A=
=0A=
yoav@nvme195:~$ sudo cat /proc/3083/stack=0A=
[<0>] do_exit+0xd7/0xa50=0A=
[<0>] do_group_exit+0x34/0x90=0A=
[<0>] get_signal+0x928/0x950=0A=
[<0>] arch_do_signal_or_restart+0x41/0x260=0A=
[<0>] irqentry_exit_to_user_mode+0x13b/0x1d0=0A=
[<0>] irqentry_exit+0x43/0x50=0A=
[<0>] sysvec_reschedule_ipi+0x65/0x110=0A=
[<0>] asm_sysvec_reschedule_ipi+0x1b/0x20=0A=
=0A=
At this point, the server is no longer able to serve I/O, yet the kernel is=
=0A=
still waiting for completion of the partition-scan reads, preventing proper=
=0A=
shutdown and recovery.=0A=
=0A=
Restart requires serving partition scan I/O=0A=
=0A=
Even without a crash, restarting the userspace application requires handlin=
g=0A=
these implicit partition-scan requests. This is undesirable for our use cas=
e,=0A=
as the device contents are managed remotely and partition probing is not al=
ways=0A=
meaningful or wanted.=0A=
=0A=
No way to suppress partition scanning in ublk=0A=
=0A=
We considered introducing an option to set GD_SUPPRESS_PART_SCAN at device=
=0A=
startup, and possibly triggering partition scanning later from userspace wh=
en=0A=
appropriate. However, it is not clear whether this is the correct approach,=
 nor=0A=
from which context such a rescan should safely be initiated.=0A=
=0A=
Questions / discussion points=0A=
=0A=
Is there an existing, recommended way for ublk devices to suppress automati=
c=0A=
partition scanning at START_DEV time?=0A=
=0A=
Would it make sense to add a ublk-specific option to control=0A=
GD_SUPPRESS_PART_SCAN, similar to how some other drivers handle this?=0A=
=0A=
Are there alternative approaches to avoid blocking behavior during device=
=0A=
startup without requiring kernel changes?=0A=
=0A=
We would appreciate guidance on the expected behavior here and whether this=
 is=0A=
something the ublk subsystem should expose more control over.=0A=
=0A=
Thanks,=0A=
Yoav=
