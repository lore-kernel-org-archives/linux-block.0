Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DCC345EAB;
	Fri, 28 Aug 2026 05:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895802; cv=fail; b=tVv5wU1sdmWMZazmA199867JIrZYmdK5bfceLNc/b2eZajUw2kKNMhjmizPBCJ02X3/rERLDYYp4SmYD9oMcnKHzYkiZxyp2CpyWaCc0nrxx28iAVu3Y/ZklXe9RATkkPQl22j3uguPyGdL0EVEP5OccyybNlE29Zr9+lMEYfgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895802; c=relaxed/simple;
	bh=+pPmemO7dS5KAawiG9vhvSXVokQAl9zqZOzDGemIFwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=beacL/dIChj3kIpCxwl/Ttptp8J2wygMMMC4LQDWEpH/3HVWSvK5mlvjcmxbBn1cQ9FGcrC2jjp3Oa2FeZTCN40VoERLpYaCbokVfoHN2EH/Qbp+v5YB/hNUVtmGRgYSfhr3Msou76QRIgRDeiHRdj7m0glCK8L2WlHTlpP7bhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rPyw1496; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rPyw1496"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkjcjQbDWHWf0/COK0H77oNYPP4Su8Ln22+deEEPq6JQUPNuShHM4qMp0KLvVRypsv4aYGwMBtuW3VCmkzffkTzu/u8tNHS3a7BGMqk1l3OngrFZSR7bJpek5Y73gs7r2M7LpdMgjmaSOD2uy68yzHTUzZAWFZ07LT/4V8lZsEAsz9MInnjIwz/fj8a+Kq4UoDLvCXKt3zR1PnjCNuNS3OLAvEtzRfbOuITzHXVz694HNaLfXGo0hwQnUGgWLBXp+TzWx6At7e3CbK5yKVRR4BQC9xFcW0QgsT/r3sIdryx0IJTmtmYUqKP6V3DiotzJofakWuCseiWCAXDwt4GDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeIxS0rfI133bq0pjPW7Ct5uepLGJGALCEaiCclV5x4=;
 b=rm+W7HqIO+5n2Bla7aCdlneklZwWrGZDiuLRvk/57lBkDVfCz+1S36VkNLVsN3L26Vv+Atpak2Uf6zlgV6K7NCKnk/lAmT+iCShjIF+WouQbK3mfRkh4rLPYgIRkGrB0jWF8Fgs9Qlo/myuvFeEPfJXbk3fpmeulqr5hxKYbo8FL+uh1JehCOEbFMlJLzboTtuzZzjpPC6qYv9rfQjNLCRtQ4TMTilpEgIvOYEcnCypv7aObU4wsyS4QcVRQj6LvPBfzef37iYGZVu+UsH+Z5QQ+uzlmc9EtVgQf1Qc5M8xwHgLNJ2Rjw7paiQaC49ykWhZbUX3H/c71+fhkG/IxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeIxS0rfI133bq0pjPW7Ct5uepLGJGALCEaiCclV5x4=;
 b=rPyw1496hlcMP+vxTbVIrp98CYXSCA8jqYgaw7B4kBHRGCmUHsQw7IkgU9VhtlnoMZnsvnzAkKDvRXMq9ru8srFo+CQ3bs+Gh4SxtGIaeaFh4JKQiVg8WWEWvfoOg1quteTFvzFKbjBEnAwEWtqvic/9rai78doTMxJ7F5+RvUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 28 Aug
 2026 05:43:17 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 05:43:17 +0000
Message-ID: <c5c2b503-e273-4aa5-ad9f-f7afee02ab9e@amd.com>
Date: Fri, 28 Aug 2026 11:13:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Silent SATA read corruption with dma-iommu on AMD
 600-series AHCI (6.19 good, 7.0+ bad)
To: Mikael Etienne <mikael1022bzh@gmail.com>, iommu@lists.linux.dev,
 linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Cc: regressions@lists.linux.dev, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
References: <CAHEgv3TiJUvS=Hustyem0ts8jkbFVAdzBazmPhCbv2sNnTsZkg@mail.gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <CAHEgv3TiJUvS=Hustyem0ts8jkbFVAdzBazmPhCbv2sNnTsZkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::31) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 98496b26-e22a-4008-7f9c-08df04c742e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|3023799007|6133799003|22082099003|18002099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	epLtQBoSrzLnwURkZtb7F2ouhxGaAHxZaT3s2tkVZeVz/d43hTaHC5STxhAcM6SpFD10V9AEGlVM1qU4FJ69/JuSINctJrqHgD7zB+AuxPuq2Ryy47t/F+jeEWK6RRPKd9AtatiNzRG77pC9tKV4s+iV/W9PU759huljukos0j+R09E8s395lVQTao2X3jm4w3wj1phoWCqroRKAvB2DfAzaQRnfUS0pKLag7HaHiPAehxZkOKwzdXbuzTYleZVslPzGDgP5e4nA3fsh9n1U4bt4KnVBtLsToMOOK2AyPxEGWnVcqfW1F17ksBSgo89m7QR8eQylgP0DJrOqFoMQL7H6Bt7CiOUU3UZ3jWHesccX0QSe6ZqlrGH17edl1d/SB1EjYGtTk9D9Aa7+to+49M2jBIb5/IryQpqokUNoeIR4wtTyMgkASQwzvHk49KuSNIQMHL+LMizXQ+BGfCZ5uxJtDOLMoG23z2xEZhJpfA8tgUOsipJC6+NKgbOS+9/4W5/tc9Wnjg2iRlEuZqjj34oiPaXmaKLW0NNdHfl/tTu5vkYMd8LTPp8FUS4eU+K2GM7zApg0YNvDeqotu/kiEFLJwy5sO858Uh1zjiOJwCc17rt6u5725z795wSD9DtOWgIpISDMfy8pLRiDVhcY0OS8SXTGqcxAusG2pFGEJRI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWJUNi9mR0RQcnhtaUdJWVJTTjcwYzdicFlJMXZVaWZPOG1vOERpRDRFRkpH?=
 =?utf-8?B?Mkh4TDlpOTFveXdlMXY4WVI0WkNYaHRQcUgzQUFaS0h5bmUxTUIxbE9Wek0z?=
 =?utf-8?B?RTdVOEZpQWFhNXJkNFM5b2JiV3psYjlYcWl1VHZPa294VVhvTkRXZXoyNnZk?=
 =?utf-8?B?TDZNWUZwVmo2Um43dWwrVUtjTjQzYlRuZHp1dEE5ZUtBNmtjd2ZSNGFCZGJw?=
 =?utf-8?B?WU9RMTRUVmdwcm04VXBWSHQwSkxYSVc0SHBpWGJyV1g1djVkako2SXJRenpK?=
 =?utf-8?B?TnVNcTdUWDFTc0pyN0RiZEhaRkc1RkkvS0J4bnRpSE12bkN4R0Z4VVdTemFS?=
 =?utf-8?B?RGhxTVFiUXJSWC9YazFDaGRqbkl5V3Q5Vm9COXIxTkZiYkxBU3JOeDEvQUtI?=
 =?utf-8?B?Qi95cXZEdnZqN1dLNWdSbnpNWWVIWUZzT21Tek9iZEdKRHF5SC9uZGdmdkFN?=
 =?utf-8?B?b0hyZ1JCUnY3Y1N0V1BVVFZndmQya3FCbkZQTEdLd0RtbWFoWEwxUTR6ZEJT?=
 =?utf-8?B?NnVpTmhNZmFEcTc2WGJyaHcrN00zWWZvbTBpcHd4MXUvNGQrYzRPYU90emV5?=
 =?utf-8?B?QXdBRTUwWjlXbUEyRlBzSnU1Qjc4TkwwbEZucmRncnd0WEtsOTMxL1RDdk1p?=
 =?utf-8?B?SC9pU3lmWU1NQURWR2xraCt4VkFoc2xOZ0F4bk5kaUcwT3RCdGZoL1lvQXJa?=
 =?utf-8?B?RTYxRWZweS9mNm84S1JkQXJGcHdYb0l2b1JGbm4vd0QyUUpaZWZMeEtEWHJv?=
 =?utf-8?B?NXZZYkVER1ExQmc0TXJlWHV3Rzc4d21VeitBSHJDVDNIeXdNd3RRK0dwUmpx?=
 =?utf-8?B?bHRHL0dEWWRmSHVMSmhRYlcyZHFhV3BWZEtWUnJZYmxJazNiWUpXbjlxakFo?=
 =?utf-8?B?QkF2MWtmREsyRDhBSHpDVkhyTlRHUnJyb1JTVGJZSnFrdWlPUWJyMmkrY2FN?=
 =?utf-8?B?eVhrVGdSK2YvbURHTWRlcGJtaTNmRkdwakMxallwR1FSZUJidUk0aHk0dVo3?=
 =?utf-8?B?TU93c0dkNTBNWmtVTzlYOXI3TW5BY1ZXWG1kYURvY3dDVnNtRFQrVExuci9J?=
 =?utf-8?B?cTJNTnF3N3NYdDczaGVkMjFWcUFtTHU4dGJpalN1aHB1VFBvSkV1emFNV0FB?=
 =?utf-8?B?b2ZNK2lwUjVxenBWQjZPQ0RpOTQ5ZmhHQVMvcWpnOER0T0ZqRFVwYXdDOEsv?=
 =?utf-8?B?cytoVEJZa0Jrby9reEpacDFxcVEyS0w2Qm1MS3cvNE9mNmdjeW5lQkVtQ1Zi?=
 =?utf-8?B?ZE9aRWwvUVMzUkJFSVByOG1JMFBnaFI3WnlTLzUrd2wrQWszZHE3U05YZy90?=
 =?utf-8?B?RFhyWTJocFdXZWxOMHp2N3VGZU1CVTNhSUpUaUNESEpDdm9VSTVCRkgzMGkr?=
 =?utf-8?B?b242YkllR1BqUUhlVXF3R3NJaDdaN1lwUUlFblRxUW90bVZ5aVRBVktRWThh?=
 =?utf-8?B?RzVCY3VMN1NMOWF6N0tueEppR0R1WTZpMXNLeENlQTRrbllpWVNLRmc1eHI5?=
 =?utf-8?B?MEFodjZ5YU1taUlKUkxEVUZhZUpLTGxRMC9GQ3BsS0JWVHRqQS9YMW4zL1dh?=
 =?utf-8?B?TmVoUGlacG1tNU5nT3c5UDlDelU5Q3NUczJCZE9mSVNHa3gyNnpTTDFnbmpR?=
 =?utf-8?B?blNFZFVYdzFsaEh5ZDkwbldzU2V4STB0UmNYb2dBNkhNeWNhU2pjRHJ0WXJI?=
 =?utf-8?B?WVBSeGtiNFpjN090THhuVkh6ekFtM2VTNWlGMERMUzh6dzZNTWlFQ3FMZzhT?=
 =?utf-8?B?Tzk4RVFzVHIwRzZGMU83N3JOcmJZUWdhOCtyZVd0cTB5RzVyN0Z4WTlKdVR3?=
 =?utf-8?B?dnBEd3hsLzNLTTNYUmhGNmdzOVZsZkhqcGJMY1lGS0VpeU9OMndUMVUveW9D?=
 =?utf-8?B?ZnpicjFXR2JnWkVjbGNMZUFhYUZSQXdQMVBrRlRvS1E2a2daa0RRd1dtQXBM?=
 =?utf-8?B?ZitaOUUzRTREVS84T243bklmbUI2c1c4THRVR2FONGVzWmQrbklrNWI5Nmo0?=
 =?utf-8?B?MTVKcXI2QllwT0lqSWp2S3N3dXpuUDJhLysrT2pOOHVwZEhLTmMrUE5YUVRM?=
 =?utf-8?B?dXhKd256M0tTYzI5OElIUzhHMHJEN29jU0twcVdGQnppOVZFYlVqVVVmTCs1?=
 =?utf-8?B?SVR5VmNjQjFZcEVCeVVSZDJVSHNrUXY1WS9GYW9iOGk4bDJ6czNjdTA1RjUw?=
 =?utf-8?B?UHhKenlRSktNM0pQbG9LZGlJVGRRTytnVjdCaFI5TGJVbGRUQWRuU0phVm5j?=
 =?utf-8?B?R0RndHUxTzVuT1hBNFFKOFltajRrT212MVRNc3NBYldoNHNsK1ZPS0dBNmZU?=
 =?utf-8?B?b2ltenk0MlM5RFljL0MzdXBLbmpaQVhEaE5XTnhpZ3ZjR2orMHpsUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98496b26-e22a-4008-7f9c-08df04c742e2
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 05:43:17.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uuYSDIacHyepVS29SWz51OPBhMEaBogS5pGm7l3fqg1MkQlMJDTaeH1eiJ7PFBXTfsUmDLIkc2AIOtAtsG3Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714


Mikael,

Thanks for the detailed report!

Can you please apply Commit 1e75a8255f11c81fb and retest. Also boot with
`amd_iommu=pgtbl_v2`?


@Mario, Can you look into this issue? Is this similar to the one you were
debugging internally?


-Vasant


On 8/28/2026 10:20 AM, Mikael Etienne wrote:
> You don't often get email from mikael1022bzh@gmail.com. Learn why this is important<https://aka.ms/LearnAboutSenderIdentification>
> Hi,
> 
> Since Linux 7.0 I observe silent read corruption on SATA disks behind an AMD
> 600-series chipset AHCI controller. AHCI/libata, the block layer, the IOMMU and
> PCIe AER report no error at all; only consumers that validate the returned bytes
> (btrfs data checksums, fio --verify) notice. SMART stays PASSED throughout.
> 
> Hardware, up front because it may matter: AMD Ryzen 7 8700G, with the SATA
> controller integrated in the chipset:
> 
> 0e:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD]
> 600 Series Chipset SATA Controller [1022:43f6] (rev 01)
> 
> This is the same SoC as bug 219609, where dma-iommu was already identified as the
> trigger for a different device class (NVMe). Details in section 6.
> 
> Two observations sharply constrain the failure:
> 
> 1. Once corruption starts, rebooting with the same kernel and the same command
> line, WITHOUT rewriting the test file, makes the very same blocks verify
> correctly again. Continued reads can later trigger the failure again. I have
> therefore observed no persistent corruption of the test file contents; this
> behaves like transient read-path state.
> 
> 2. Adding only "iommu=pt" to the command line (nothing else changed): no
> corruption observed over 40 consecutive verification passes, 10 TiB re-read
> in 17 h. In the default translated mode the same test failed after 768 GiB
> / 3 h 25 m.
> 
> Good/bad boundary: 6.18.16 and 6.19.x are clean, every 7.0.x and 7.1.x is
> affected. Kernel is untainted (/proc/sys/kernel/tainted = 0), no out-of-tree or
> DKMS modules loaded.
> 
> Important caveat, stated up front: all kernels tested so far are Fedora-packaged.
> I have not confirmed this on vanilla upstream and I have not bisected. See "What
> I can and cannot do" at the end.
> 
> #regzbot introduced: v6.19..v7.0
> 
> 
> ## 1. Test matrix
> 
> Test file: 256 GiB fio canary with crc32c verification, on btrfs, on the 12 TB
> drive (WDC WD120EFGX-68CPHN0).
> 
> 7.1.10-200.fc44, translated (DMA-FQ):
> first verify failure after 768 GiB re-read / 3 h 25 m
> once in the failed state, a plain 4 GiB O_DIRECT read of the same file
> produced tens of thousands of further csum failures
> btrfs corruption_errs reached 20,858,094 in that session
> reboot -> counters back to 0, same file verifies clean again
> 
> 7.1.10-200.fc44, iommu=pt (identity):
> 40 consecutive clean passes, 10 TiB re-read, 17 h
> btrfs corruption_errs = 0, zero kernel error lines
> 
> Earlier, translated mode, other workloads on the 8 TB drive:
> read-only workload 9 h 30 m clean
> deduplication workload failed at 3 h 17 m
> sequential write failed at 6 h 35 m
> 
> I have not yet run enough boots to give a proper min/median/max distribution.
> The 3 h 25 m figure above is a single, carefully instrumented data point.
> 
> 
> ## 2. Reproducer
> 
> fio 3.40, io_uring engine (libaio not tested yet).
> 
> Write the canary once:
> 
> fio --name=canary --filename=/srv/12to/.sata-canary --size=256G --bs=128k \
> --ioengine=io_uring --direct=1 --iodepth=32 \
> --verify=crc32c --verify_interval=4096 --rw=write \
> --do_verify=0 --fsync_on_close=1
> 
> Then loop the verification until it fails:
> 
> while :; do
> fio --name=canary --filename=/srv/12to/.sata-canary --size=256G --bs=128k \
> --ioengine=io_uring --direct=1 --iodepth=32 \
> --verify=crc32c --verify_interval=4096 --rw=write \
> --verify_only=1 --verify_fatal=1 || break
> done
> 
> The reboot-without-rewrite protocol: when it fails, reboot and re-run only the
> verification loop above. The canary file is never rewritten. It verifies clean.
> 
> 
> ## 3. Corruption signature
> 
> The frequent mode is a 4096-byte page read back as all zeros. btrfs reports
> "csum 0x8941f998", which is the CRC32C of a zero-filled 4 KiB block.
> 
> The interesting mode is a structured permutation. From one btrfs report, inode
> 6646:
> 
> offset A offset B delta
> 1314816 1355776 40960
> 1318912 1351680 32768
> 1323008 1347584 24576
> 1327104 1343488 16384
> 1331200 1339392 8192
> 
> Verified programmatically from the raw btrfs csum lines: the data read at offset
> A is exactly what was expected at offset B, and vice versa. Five reciprocal
> pairs, symmetric around the pivot at 1335296 -- a run of 11 consecutive 4 KiB
> blocks in reverse order, the centre block mapping onto itself.
> 
> This pattern suggests incorrect DMA/scatterlist mapping or descriptor handling,
> because the affected chunks form a structured permutation rather than random bit
> corruption. It does not by itself identify the faulty layer.
> 
> 
> ## 4. Hardware and storage stack
> 
> Gigabyte X870I AORUS PRO ICE, BIOS FB1c (2026-07-21)
> AMD Ryzen 7 8700G w/ Radeon 780M Graphics
> 32 GB DDR5 non-ECC, single stick, JEDEC 4800 (EXPO/XMP off)
> 
> 0e:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD]
> 600 Series Chipset SATA Controller [1022:43f6] (rev 01)
> 
> ahci flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso
> sadm sds apst
> 32 command slots, queue_depth 32, max_segment_size 65536, max_segments 168,
> max_sectors_kb 4096, scheduler bfq
> 
> IOMMU: AMD-Vi, "Default domain type: Translated",
> "DMA domain TLB invalidation policy: lazy mode"
> Controller iommu_group type: DMA-FQ, becomes "identity" with iommu=pt
> 
> Test drive: /dev/sdb1 -> /srv/12to
> btrfs, data single, metadata DUP, mounted rw,noatime,compress=zstd:3,
> space_cache=v2. Plain partition: no LVM, no dm-crypt, no mdraid.
> 
> Drives that showed the symptom (three different drives, one taken new out of
> its box and affected within hours of first use):
> WDC WD120EFGX-68CPHN0, fw 85.00B85 (btrfs, quantified above)
> Seagate ST8000VN004-2M2101, fw SC60 (btrfs)
> WDC WD101EFBX-68B0AN0 (ext4)
> 
> NVMe devices in the same machine have never shown the symptom.
> 
> 
> ## 5. What I ruled out
> 
> - NCQ: queue_depth 32 -> 1, no change (304 vs 769 csum failures per 4 GiB read)
> - transfer size: max_sectors_kb 4096 -> 64, no change (388 vs 342)
> - both combined: no change
> - SATA link power management: already max_performance on the affected ports
> - PCIe ASPM: disabled on that link
> - PCIe AER: all correctable and non-fatal counters at 0
> - SATA link CRC (SMART attribute 199): 0 on every drive
> - temperature: 41-56 C
> - swiotlb=force does NOT help, which is consistent with the dma-iommu path
> still being used underneath
> - not btrfs-specific: at the same moment, ext4 on a second drive reported
> "bad header/extent: invalid magic - magic 0", and parted reported a corrupt
> GPT on it. Both drives read correctly again after a reboot.
> 
> btrfs is what first exposed the problem, through its data checksums. Filesystems
> without user-data checksums may hand affected data to userspace without noticing,
> although metadata validation or application-level checksums can still catch some
> of it -- which is what happened with ext4 and parted above.
> 
> 
> ## 6. Possibly related
> 
> Bug 219609, "File corruptions on SSD in 1st M.2 socket of AsRock X600M-STX +
> Ryzen 8700G". Christoph Hellwig writes there that "the problem only happens when
> using the dma-iommu code (with or without swiotlb buffering for unaligned /
> untrusted data)", and that iommu=pt or amd_iommu=off fix it.
> 
> Same SoC (Ryzen 8700G) as this machine, but a different device class (SATA/AHCI
> here, NVMe there) and a different kernel window, so I am reporting separately and
> cross-referencing rather than piling onto that bug.
> 
> 
> ## 7. What I can and cannot do
> 
> This is a production home server, not a test bench, so I want to be straight
> about it:
> 
> I CAN: run any specific test, boot parameter or debug patch you ask for, and
> report back with full instrumentation. I have a working reproducer and
> a drive I can dedicate to it.
> 
> I CANNOT realistically: dedicate the machine to a multi-day v6.19..v7.0
> bisection. Classifying a kernel as "good" currently costs several hours
> and several TiB of reads, which makes ~13 bisection steps impractical
> for me. If someone can suggest a faster trigger, that changes.
> 
> I have not yet tested: vanilla upstream kernels, libaio instead of io_uring,
> iommu.strict=1, or amd_iommu=off. I am happy to test any of these.
> 
> Available on request, immediately: full dmesg from a bad boot and from an
> iommu=pt boot, kernel .config for good and bad, /proc/cmdline, uname -a,
> /proc/sys/kernel/tainted, lspci -nnvv, lspci -t, IOMMU group and domain types,
> queue/DMA sysfs attributes, SMART reports, AER counters, raw fio logs, the raw
> btrfs csum lines, and the script that proved the A/B swaps.
> 
> Thanks,
> 

